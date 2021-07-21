# frozen_string_literal: true

require 'rails_helper'

RSpec.describe RecipesRepository do
  let(:repo) { described_class.new }

  describe '#all' do
    subject(:all) { repo.all }

    context 'when fetching the credentials fails' do
      before do
        allow(Rails.application.credentials.config)
          .to receive(:fetch)
          .with(:test)
          .and_return({})
      end

      specify { expect { all }.to raise_error(KeyError) }
    end

    context 'when the api client returns valid entries' do
      let(:client) { instance_double(Contentful::Client) }
      let(:recipe_mapper) { instance_double(RecipeMapper, call: recipe) }
      let(:recipe) { instance_double(Recipe) }
      let(:raw_entry) do
        double(
          Contentful::Entry,
          id: 'test-id',
          title: 'test-title',
          photo: 'test-photo'
        )
      end

      before do
        allow(Contentful::Client)
          .to receive(:new)
          .with(
            space: 'test_space',
            access_token: 'test_token'
          ).and_return(client)

        allow(client)
          .to receive(:entries)
          .with(content_type: 'recipe')
          .and_return([raw_entry])

        allow(RecipeMapper)
          .to receive(:new)
          .with(contentful_entry: raw_entry)
          .and_return(recipe_mapper)
      end

      it { is_expected.to be_an(Array) }

      specify { expect(all.count).to eq 1 }
      specify { expect(all.first).to eq recipe }
    end
  end

  describe '#find' do
    subject(:find) { repo.find(id: 'test-id') }

    let(:client) { instance_double(Contentful::Client) }
    let(:entry) { instance_double(Contentful::Entry) }

    before do
      allow(Contentful::Client)
        .to receive(:new)
        .with(
          space: 'test_space',
          access_token: 'test_token'
        ).and_return(client)

      allow(client)
        .to receive(:entry)
        .with('test-id')
        .and_return(entry)
    end

    context 'when entry is not found' do
      let(:entry) { nil }

      it 'raises a record not found exception' do
        expect { find }.to(raise_error { RecordNotFound })
      end
    end

    context 'when entry is found' do
      let(:mapper) { instance_double(RecipeMapper, call: recipe) }
      let(:recipe) { instance_double(Recipe) }

      before do
        allow(RecipeMapper)
          .to receive(:new)
          .with(contentful_entry: entry)
          .and_return(mapper)
      end

      it { is_expected.to eq recipe }
    end
  end
end

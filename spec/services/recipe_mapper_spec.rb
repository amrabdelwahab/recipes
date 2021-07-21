# frozen_string_literal: true

require 'rails_helper'

RSpec.describe RecipeMapper do
  let(:mapper) { described_class.new(contentful_entry: contentful_entry) }
  let(:contentful_entry) do
    double(
      Contentful::Entry,
      id: 'test-id',
      title: 'test-title',
      description: 'test-description',
      photo: double('asset', file: double('file', url: 'test-url'))
    )
  end

  describe '#call' do
    subject(:mapped_recipe) { mapper.call }

    context 'when everything exists' do
      let(:tag) { double(Contentful::Entry, name: 'test-tag') }
      let(:chef) { double(Contentful::Entry, name: 'test-chef') }

      before do
        allow(contentful_entry)
          .to receive(:fields)
          .and_return({ tags: [tag], chef: chef })
      end

      it { is_expected.to be_a Recipe }

      it 'maps all the fields correctly', :aggregate_failures do
        expect(mapped_recipe.id).to eq 'test-id'
        expect(mapped_recipe.title).to eq 'test-title'
        expect(mapped_recipe.description).to eq 'test-description'
        expect(mapped_recipe.photo_url).to eq 'test-url'
        expect(mapped_recipe.tags).to match_array ['test-tag']
        expect(mapped_recipe.chef_name).to eq 'test-chef'
      end
    end

    context 'when tags does not exist' do
      let(:chef) { double(Contentful::Entry, name: 'test-chef') }

      before do
        allow(contentful_entry)
          .to receive(:fields)
          .and_return({ chef: chef })
      end

      it { is_expected.to be_a Recipe }

      it 'maps all the fields correctly' do
        expect(mapped_recipe.tags).to match_array []
      end
    end

    context 'when chef does not exist' do
      let(:tag) { double(Contentful::Entry, name: 'test-tag') }

      before do
        allow(contentful_entry)
          .to receive(:fields)
          .and_return({ tags: [tag] })
      end

      it { is_expected.to be_a Recipe }

      it 'maps all the fields correctly' do
        expect(mapped_recipe.chef_name).to be_nil
      end
    end
  end
end

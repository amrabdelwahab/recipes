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
      let(:raw_entry) do
        double(
          Contentful::Entry,
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
      end

      it { is_expected.to be_an(Array) }

      specify { expect(all.count).to eq 1 }
      specify { expect(all.first.title).to eq 'test-title' }
      specify { expect(all.first.photo).to eq 'test-photo' }
    end
  end
end

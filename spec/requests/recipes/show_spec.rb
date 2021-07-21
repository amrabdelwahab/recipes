# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Recipe show', type: :request do
  let(:recipes_repository) { instance_double(RecipesRepository) }

  before do
    allow(RecipesRepository)
      .to receive(:new)
      .and_return(recipes_repository)
  end

  context 'when the id is found' do
    let(:recipe) do
      instance_double(
        Recipe,
        title: 'test-title',
        description: 'test-description',
        photo_url: 'test-url',
        chef_name: chef_name,
        tags: tags
      )
    end

    before do
      allow(recipes_repository)
        .to receive(:find)
        .with(id: 'test-id')
        .and_return(recipe)
    end

    context 'with both tags and chef' do
      let(:chef_name) { 'test-chef' }
      let(:tags) { ['test-tag'] }

      it 'renders the page successfully', :aggregate_failures do
        get '/recipes/test-id'

        expect(response).to be_successful
        expect(response.body).to include('test-title')
        expect(response.body).to include('test-description')
        expect(response.body).to include('test-tag')
        expect(response.body).to include('By: test-chef')
        expect(response.body).to include('test-url')
      end
    end

    context 'with neither tags and chef' do
      let(:chef_name) { nil }
      let(:tags) { [] }

      it 'renders the page successfully' do
        get '/recipes/test-id'

        expect(response).to be_successful
      end
    end
  end

  context 'when the id is not found' do
    before do
      allow(recipes_repository)
        .to receive(:find)
        .with(id: 'test-id')
        .and_raise(RecordNotFound)
    end

    it 'renders the page successfully', :aggregate_failures do
      get '/recipes/test-id'

      expect(response.status).to be 404
    end
  end
end

# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Recipes list', type: :request do
  let(:recipes_repository) { instance_double(RecipesRepository, all: recipes_response) }
  let(:recipes_response) { [] }

  before do
    allow(RecipesRepository)
      .to receive(:new)
      .with(no_args)
      .and_return(recipes_repository)
  end

  context 'when the recipes API returns an empty list', :aggregate_failures do
    it 'shows no recipes available' do
      get '/recipes'

      expect(response).to be_successful
      expect(response.body).to include('No Recipes available')
    end
  end

  context 'when the recipes API returns a list of recipes' do
    let(:recipes_response) do
      [
        instance_double(Recipe, title: 'Test Recipe', photo_url: 'test-url', id: 'test-id')
      ]
    end

    it 'renders a list of recipes', :aggregate_failures do
      get '/recipes'

      expect(response).to be_successful
      expect(response.body).to include('Test Recipe')
    end
  end
end

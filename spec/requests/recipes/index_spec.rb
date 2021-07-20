require 'rails_helper'

RSpec.describe 'Recipes list', type: :request do
  it 'renders a list of recipes', :aggregate_failures do
    get '/recipes'

    expect(response).to be_successful
    expect(response.body).to include('Recipes List')
  end
end
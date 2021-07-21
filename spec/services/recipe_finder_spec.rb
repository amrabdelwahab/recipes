# frozen_string_literal: true

require 'rails_helper'

RSpec.describe RecipeFinder do
  describe '.call' do
    subject { described_class.call('test-id') }

    let(:recipes_repository) { instance_double(RecipesRepository) }
    let(:recipe) { instance_double(Recipe) }

    before do
      allow(RecipesRepository)
        .to receive(:new)
        .with(no_args)
        .and_return(recipes_repository)

      allow(recipes_repository)
        .to receive(:find)
        .with(id: 'test-id')
        .and_return(recipe)
    end

    it { is_expected.to eq recipe }
  end
end

# frozen_string_literal: true

require 'rails_helper'

RSpec.describe RecipesLister do
  describe '.call' do
    subject { described_class.call }

    let(:recipes_repository) { instance_double(RecipesRepository, all: []) }

    before do
      allow(RecipesRepository)
        .to receive(:new)
        .with(no_args)
        .and_return(recipes_repository)
    end

    it { is_expected.to match_array [] }
  end
end

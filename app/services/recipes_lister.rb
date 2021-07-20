# frozen_string_literal: true

class RecipesLister
  def self.call
    ::RecipesRepository.new.all
  end
end

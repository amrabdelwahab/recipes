# frozen_string_literal: true

class RecipeFinder
  def self.call(id)
    ::RecipesRepository.new.find(id: id)
  end
end

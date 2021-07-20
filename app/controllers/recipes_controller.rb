# frozen_string_literal: true

class RecipesController < ApplicationController
  def index
    @recipes = RecipesLister.call
  end
end

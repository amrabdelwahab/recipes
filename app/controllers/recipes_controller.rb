# frozen_string_literal: true

class RecipesController < ApplicationController
  def index
    @recipes = RecipesLister.call
  end

  def show
    @recipe = RecipeFinder.call(params[:id])
  end
end

# frozen_string_literal: true

class Recipe
  attr_reader :title, :photo

  def initialize(title:, photo:)
    @title = title
    @photo = photo
  end
end

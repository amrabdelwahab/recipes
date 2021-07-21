# frozen_string_literal: true

class Recipe
  attr_reader :id, :title, :description, :photo_url, :tags, :chef_name

  def initialize(id:, title:, description:, photo_url:, tags:, chef_name:)
    @id = id
    @title = title
    @description = description
    @photo_url = photo_url
    @tags = tags
    @chef_name = chef_name
  end
end

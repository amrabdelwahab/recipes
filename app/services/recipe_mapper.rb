# frozen_string_literal: true

class RecipeMapper
  def initialize(contentful_entry:)
    @contentful_entry = contentful_entry
  end

  def call
    Recipe.new(
      id: @contentful_entry.id,
      title: @contentful_entry.title,
      description: @contentful_entry.description,
      photo_url: @contentful_entry.photo&.file&.url,
      tags: tags,
      chef_name: chef_name
    )
  end

  private

  def tags
    @contentful_entry.fields.fetch(:tags, []).map(&:name)
  end

  def chef_name
    @contentful_entry.fields[:chef]&.name
  end
end

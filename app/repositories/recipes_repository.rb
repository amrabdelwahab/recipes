# frozen_string_literal: true

class RecipesRepository
  def all
    contentful_entries.map do |entry|
      Recipe.new(
        title: entry.title,
        photo: entry.photo
      )
    end
  end

  private

  def contentful_entries
    @contentful_entries ||= contentful_client.entries(
      content_type: 'recipe'
    )
  end

  def contentful_client
    @contentful_client ||= Contentful::Client.new(
      space: credentials.fetch(:contentful_space),
      access_token: credentials.fetch(:contentful_access_token)
    )
  end

  def credentials
    @credentials ||= Rails.application.credentials.config.fetch(Rails.env.to_sym)
  end
end

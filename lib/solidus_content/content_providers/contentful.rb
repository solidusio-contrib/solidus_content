# frozen_string_literal: true

require 'contentful'

class SolidusContent::ContentProviders::Contentful
  class << self
    def from_entry_type(entry_type)
      raise ArgumentError, 'contentful_space_id is required' unless entry_type.options[:contentful_space_id]
      raise ArgumentError, 'contentful_access_token is required' unless entry_type.options[:contentful_access_token]

      new(
        contentful_space_id: entry_type.options[:contentful_space_id],
        contentful_access_token: entry_type.options[:contentful_access_token],
      )
    end
  end

  def initialize(contentful_space_id:, contentful_access_token:)
    @contentful_space_id = contentful_space_id
    @contentful_access_token = contentful_access_token
  end

  def process_webhook(body)
    renderful.invalidate_cache_from_webhook(body)
  end

  def call(input)
    type_options = input.dig(:type_options)
    entry_id = input.dig(:options, :entry_id)

    client = Contentful::Client.new(
      space: type_options[:contentful_space_id],
      access_token: type_options[:contentful_access_token],
    )

    entry = client.entry(entry_id)

    input.merge(
      data: entry.fields,
      provider_client: client,
      provider_entry: entry,
    )
  end

  private

  def renderful
    Renderful::Client.new(
      provider: Renderful::Provider::Contentful.new(
        contentful: Contentful::Client.new(
          space: @contentful_space_id,
          access_token: @contentful_access_token,
        )
      )
    )
  end
end

class SolidusContent::ContentProviders::Contentful::Form
  include ActiveModel::Model

  def to_model
    # ...
  end
end

class WebhooksController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create
    EntryType.all.each do |entry_type|
      entry_type.content_provider.process_webhook(request.raw_post)
    end

    head :no_content
  end
end

# frozen_string_literal: true

module SolidusContent
  # This module will be the namespace for default providers
  module Providers
  end

  def self.provider_names
    SolidusContent.config.providers.keys
  end

  def self.human_provider_name(name)
    I18n.t("solidus_content.providers.#{name}")
  end

  # Register all the default providers
  config.register_provider :json, :JSON
  config.register_provider :raw, :RAW
  config.register_provider :yaml, :YAML
  config.register_provider :contentful, :Contentful
  config.register_provider :prismic, :Prismic
  config.register_provider :solidus_static_content, :SolidusStaticContent
end

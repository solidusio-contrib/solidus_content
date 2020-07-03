# frozen_string_literal: true

require 'solidus_core'
require 'solidus_support'

require 'solidus_content/version'
require 'solidus_content/engine'
require 'solidus_content/configuration'

module SolidusContent
  class << self
    def table_name_prefix
      'solidus_content_'
    end

    def config
      @config ||= Configuration.new
    end

    def configure
      yield config
    end

    def provider_names
      SolidusContent.config.providers.keys
    end

    def human_provider_name(name)
      I18n.t("solidus_content.providers.#{name}")
    end
  end

  # This module will be the namespace for default providers
  module Providers
  end

  # Register all the default providers
  config.register_provider :json, :JSON
  config.register_provider :raw, :RAW
  config.register_provider :yaml, :YAML
  config.register_provider :contentful, :Contentful
  config.register_provider :prismic, :Prismic
  config.register_provider :solidus_static_content, :SolidusStaticContent
end

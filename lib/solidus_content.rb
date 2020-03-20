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
  end

  # This module will be the namespace for default providers
  module ContentProviders
  end
end

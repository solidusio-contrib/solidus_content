# frozen_string_literal: true

require 'spree/core/class_constantizer'

class SolidusContent::Configuration
  UnknownProvider = Class.new(StandardError)

  # Register of content-providers, use symbols for keys and callables as
  # values. Each content-provider will be called passing the `entry_options:` 
  # and `entry_type_options:`. 
  def content_providers
    @content_providers ||= Hash.new do |_hash, key|
      raise UnknownProvider, "Can't find a provider for #{key.inspect}"
    end
  end

  # Set to true to prevent SolidusContent from adding the default route.
  # See also the README and config/routes.rb.
  attr_accessor :skip_default_route
end

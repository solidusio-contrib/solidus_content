# frozen_string_literal: true

require 'active_support/core_ext/string/inflections'

class SolidusContent::Configuration
  UnknownProvider = Class.new(StandardError)

  # Register of content-providers, use symbols for keys and callables as
  # values. Each content-provider will be called passing the `entry_options:` 
  # and `entry_type_options:`. 
  def content_providers
    @content_providers ||= Hash.new do |hash, key|
      raise UnknownProvider, "Can't find a provider for #{key.inspect}"
    end
  end

  # Set to true to prevent SolidusContent from adding the default route.
  # See also the README and config/routes.rb.
  attr_accessor :skip_default_route

  def register_content_provider(name, provider)
    if provider.is_a? Symbol
      require "solidus_content/content_providers/#{provider.to_s.underscore}"
      provider = SolidusContent::ContentProviders.const_get(provider)
    end
    content_providers[name.to_sym] = provider
  end
end

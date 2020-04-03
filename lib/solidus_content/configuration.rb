# frozen_string_literal: true

require 'spree/core/class_constantizer'
require 'active_support/core_ext/string/inflections'

class SolidusContent::Configuration
  UnknownProvider = Class.new(StandardError)

  # Register of content-providers, use symbols for keys and callables as
  # values. Each content-provider will be called passing the `entry_options:` 
  # and `entry_type_options:`. 
  def content_providers
    @content_providers ||= Hash.new do |hash, key|
      provider = SolidusContent::ContentProviders.constants.find do |constant|
        constant.to_s.underscore == key.to_s
      end

      if provider
        hash[key.to_sym] = SolidusContent::ContentProviders.const_get(provider)
      else
        raise UnknownProvider, "Can't find a provider for #{key.inspect}"
      end
    end
  end

  # Set to true to prevent SolidusContent from adding the default route.
  # See also the README and config/routes.rb.
  attr_accessor :skip_default_route
end

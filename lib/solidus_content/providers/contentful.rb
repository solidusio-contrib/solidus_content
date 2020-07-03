# frozen_string_literal: true

module SolidusContent
  module Providers
    class Contentful
      class << self
        def call(input)
          require 'contentful' unless defined?(::Contentful)

          type_options = input.dig(:type_options)

          client = ::Contentful::Client.new(
            space: type_options[:contentful_space_id],
            access_token: type_options[:contentful_access_token],
          )

          entry = client.entry(input.dig(:options, :entry_id))

          input.merge(
            data: entry.fields,
            provider_client: client,
            provider_entry: entry,
          )
        end

        def entry_type_fields
          %i[contentful_space_id contentful_access_token]
        end
      end
    end
  end
end

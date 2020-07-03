# frozen_string_literal: true

module SolidusContent
  module Providers
    class Prismic
      class << self
        def call(input)
          require 'prismic' unless defined?(::Prismic)

          type_options = input.dig(:type_options)

          client = ::Prismic.api(
            type_options[:api_entry_point],
            type_options.dig(:api_token)
          )

          entry = client.getByID(input.dig(:options, :id))

          input.merge(
            data: entry.fields,
            provider_client: client,
            provider_entry: entry,
          )
        end

        def entry_type_fields
          %i[api_entry_point api_token]
        end
      end
    end
  end
end

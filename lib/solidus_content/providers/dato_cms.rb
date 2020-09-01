# frozen_string_literal: true

module SolidusContent
  module Providers
    class DatoCms
      class << self
        def call(input)
          require 'dato' unless defined?(::Dato)

          api_token = input.dig(:type_options, :api_token)
          environment = input.dig(:type_options, :environment).presence

          client = Dato::Site::Client.new(api_token, environment: environment)

          item_id = input.dig(:options, :item_id)
          item_version = input.dig(:options, :version).presence

          fields = client.items.find(item_id, version: item_version)

          input.merge(
            data: fields,
            provider_client: client,
          )
        end

        def entry_type_fields
          %i[api_token environment]
        end

        def entry_fields
          %i[item_id version]
        end
      end
    end
  end
end

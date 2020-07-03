# frozen_string_literal: true

require 'json'

module SolidusContent
  module Providers
    class JSON
      class << self
        def call(input)
          dir = Rails.root.join(input.dig(:type_options, :path))
          file = dir.join(input[:slug] + '.json')
          data = ::JSON.parse(file.read, symbolize_names: true)

          input.merge(data: data)
        end

        def entry_type_fields
          %i[path]
        end
      end
    end
  end
end

# frozen_string_literal: true

require 'yaml'

module SolidusContent
  module Providers
    class YAML
      class << self
        def call(input)
          dir = Rails.root.join(input.dig(:type_options, :path))
          file = dir.join(input[:slug] + '.yml')
          file = dir.join(input[:slug] + '.yaml') unless file.exist?

          data = load(file)

          input.merge(data: data)
        end

        def load(file)
          ::YAML.load_file(file).symbolize_keys
        end

        def fields
          %i[path]
        end
      end
    end
  end
end

# frozen_string_literal: true

# Let the content come from the entry itself.
module SolidusContent
  module Providers
    class RAW
      class << self
        def call(input)
          input.merge(data: input[:options])
        end

        def entry_type_fields
          []
        end
      end
    end
  end
end

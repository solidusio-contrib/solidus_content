# frozen_string_literal: true

# Let the content come from the entry itself.
module SolidusContent::Providers::RAW
  def self.call(input)
    input.merge(data: input[:options])
  end
end

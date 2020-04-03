# frozen_string_literal: true

module SolidusContent::ContentProviders::JSON
  def self.call(input)
    dir = Rails.root.join(input.dig(:type_options, :path))
    file = dir.join(input[:slug] + '.json')
    data = JSON.parse(file.read, symbolize_names: true)
  
    input.merge(data: data)
  end
end

module SolidusContent::ContentProviders::JSON
  def self.call(input)
    dir = Rails.root.join(input.dig(:type_options, :path))
    file = dir.join(input[:slug] + '.json')
    data = JSON.parse(file.read, symbolize_names: true)
  
    input.merge(data: data)
  end

  SolidusContent.config.content_providers[:json] = self
end

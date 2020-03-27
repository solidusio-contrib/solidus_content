module SolidusContent::ContentProviders::YAML
  def self.call(input)
    dir = Rails.root.join(input.dig(:type_options, :path))
    file = dir.join(input[:slug] + '.yml')
    file = dir.join(input[:slug] + '.yaml') unless file.exist?

    data = YAML.load(file.read, symbolize_names: true, filename: file.to_s)

    input.merge(data: data)
  end

  SolidusContent.config.content_providers[:yaml] = self
end

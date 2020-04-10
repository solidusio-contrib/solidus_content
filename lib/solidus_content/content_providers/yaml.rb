# frozen_string_literal: true

require 'yaml'

module SolidusContent::ContentProviders::YAML
  def self.call(input)
    dir = Rails.root.join(input.dig(:type_options, :path))
    file = dir.join(input[:slug] + '.yml')
    file = dir.join(input[:slug] + '.yaml') unless file.exist?

    data = load(file)

    input.merge(data: data)
  end

  # Ruby 2.6 deprecated passing the filename as the second argument, we'll do 
  # a feature check instead of relying on the Ruby version.
  filename_key = YAML.method(:load).parameters.rassoc(:filename).first == :key

  if filename_key
    def self.load(file)
      YAML.load(file.read, symbolize_names: true, filename: file.to_s)
    end
  else
    def self.load(file)
      YAML.load(file.read, file.to_s, symbolize_names: true)
    end
  end
end

# frozen_string_literal: true

module SolidusContent::Providers::Prismic
  def self.call(input)
    require 'prismic' unless defined?(::Prismic)
    
    type_options = input.dig(:type_options)
    entry_id = input.dig(:options, :id)

    client = ::Prismic.api(
      type_options[:api_entry_point],
      type_options.dig(:api_token)
    )

    entry = client.getByID(entry_id)

    input.merge(
      data: entry.fields,
      provider_client: client,
      provider_entry: entry,
    )
  end
end

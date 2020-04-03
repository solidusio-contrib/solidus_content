module SolidusContent::ContentProviders::Contentful
  def self.call(input)
    type_options = input.dig(:type_options)
    entry_id = input.dig(:options, :entry_id)

    client = Contentful::Client.new(
      space: type_options[:contentful_space_id],
      access_token: type_options[:contentful_access_token],
    )

    entry = client.entry(entry_id)

    input.merge(
      data: entry.fields,
      provider_client: client,
      provider_entry: entry,
    )
  end
end

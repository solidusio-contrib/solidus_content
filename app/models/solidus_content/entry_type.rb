class SolidusContent::EntryType < ActiveRecord::Base
  has_many :entries

  def content_for(entry)
    content_provider.call(
      slug: entry.slug,
      type: name,
      provider: content_provider_name,
      options: entry.options.symbolize_keys,
      type_options: options.symbolize_keys,
    )
  end

  def content_provider
    SolidusContent.config.content_providers[content_provider_name.to_sym]
  end
end

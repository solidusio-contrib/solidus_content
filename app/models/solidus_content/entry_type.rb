class SolidusContent::EntryType < ActiveRecord::Base
  has_many :entries
  after_initialize { self.options ||= {} }

  def content_for(entry)
    provider.call(
      slug: entry.slug,
      type: name,
      provider: provider_name,
      options: entry.options.symbolize_keys,
      type_options: options.symbolize_keys,
    )
  end

  def provider
    SolidusContent.config.providers[provider_name.to_sym]
  end
end

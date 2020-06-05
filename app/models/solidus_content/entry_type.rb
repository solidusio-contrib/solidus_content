# frozen_string_literal: true

class SolidusContent::EntryType < ActiveRecord::Base
  has_many :entries, dependent: :destroy

  validates :name, presence: true
  validates :provider_name, presence: true
  validate :ensure_provider_name_is_not_changed

  after_initialize { self.options ||= {} }

  scope :by_name, ->(name) { find_by!(name: name) }

  validates :name, :provider_name, presence: true

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

  def provider_name_readonly?
    persisted?
  end

  private

  def ensure_provider_name_is_not_changed
    if provider_name_changed? && persisted?
      errors.add :provider_name, :readonly
    end
  end
end

# frozen_string_literal: true

class SolidusContent::EntryType < ActiveRecord::Base
  include SolidusContent::Provider::Fields
  extend SolidusContent::SerializedJsonAccessor

  has_many :entries, dependent: :destroy

  scope :by_name, ->(name) { find_by!(name: name) }

  validates :name, presence: true
  validates :provider_name, presence: true
  validates :name, :provider_name, presence: true
  validate :ensure_provider_name_is_not_changed

  serialized_json_accessor_for :options

  after_initialize { self.options ||= {} }
  after_initialize :inject_provider_fields, if: :provider_name?

  scope :by_name, ->(name) { find_by!(name: name) }

  def content_for(entry)
    provider_class.call(
      slug: entry.slug,
      type: name,
      provider: provider_name,
      options: entry.options.symbolize_keys,
      type_options: options.symbolize_keys,
    )
  end

  def provider_class
    SolidusContent.config.providers[provider_name.to_sym]
  end

  def provider_name_readonly?
    persisted?
  end

  def fields
    return unless provider_name

    provider_class.fields
  end

  private

  def inject_provider_fields
    provider_based_attr_reader(fields)
  end

  def ensure_provider_name_is_not_changed
    return unless provider_name_changed? && persisted?

    errors.add :provider_name, :readonly
  end
end

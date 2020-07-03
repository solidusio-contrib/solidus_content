# frozen_string_literal: true

class SolidusContent::Entry < SolidusContent::ApplicationRecord
  include SolidusContent::Provider::Fields

  belongs_to :entry_type

  after_initialize { self.options ||= {} }
  after_initialize :inject_entry_fields, if: :entry_type_id?

  validates :slug, presence: true, uniqueness: { scope: :entry_type_id }

  scope :by_slug, ->(slug) { find_by!(slug: slug) }
  scope :by_type, ->(type) {
    unless type.is_a? SolidusContent::EntryType
      type = SolidusContent::EntryType.by_name(type)
    end
    where(entry_type: type)
  }

  def self.data_for(type, slug)
    by_type(type).by_slug(slug).data
  end

  def data
    content[:data]
  end

  def content
    @content ||= entry_type.content_for(self)
  end

  def entry_fields
    return unless entry_type_id?

    entry_type.provider_class.entry_fields
  end

  private

  def inject_entry_fields
    provider_based_attr_reader(entry_fields)
  end
end

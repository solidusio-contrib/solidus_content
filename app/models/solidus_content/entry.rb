# frozen_string_literal: true

class SolidusContent::Entry < ActiveRecord::Base
  extend SolidusContent::SerializedJsonAccessor

  belongs_to :entry_type

  after_initialize { self.options ||= {} }

  validates :slug, presence: true, uniqueness: {scope: :entry_type_id}

  serialized_json_accessor_for :options

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
end

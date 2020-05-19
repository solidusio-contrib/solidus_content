# frozen_string_literal: true

class SolidusContent::Entry < ActiveRecord::Base
  belongs_to :entry_type
  after_initialize { self.options ||= {} }

  scope :by_slug, ->(slug) { find_by!(slug: slug) }

  def self.data_for(entry_type_name, slug)
    get(entry_type_name, slug).data
  end

  def self.get(entry_type_name, slug)
    SolidusContent::EntryType.by_type_name(entry_type_name).entries.by_slug(slug)
  end

  def data
    content[:data]
  end

  def content
    @content ||= entry_type.content_for(self)
  end
end

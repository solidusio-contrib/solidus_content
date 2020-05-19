# frozen_string_literal: true

class SolidusContent::Entry < ActiveRecord::Base
  belongs_to :entry_type
  after_initialize { self.options ||= {} }

  scope :by_slug, ->(slug) { find_by!(slug: slug) }

  def self.data_for(entry_type, slug)
    SolidusContent::EntryType.find_by!(name: entry_type).entries.by_slug(slug).data
  end

  def data
    content[:data]
  end

  def content
    @content ||= entry_type.content_for(self)
  end
end

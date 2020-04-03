# frozen_string_literal: true

class SolidusContent::Entry < ActiveRecord::Base
  belongs_to :entry_type
  after_initialize { self.options ||= {} }

  def data
    content[:data]
  end

  def content
    @content ||= entry_type.content_for(self)
  end
end

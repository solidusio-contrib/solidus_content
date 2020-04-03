# frozen_string_literal: true

module SolidusContent::ContentProviders::SolidusStaticContent
  def self.call(input)
    slug = input.dig(:options, :slug) || input[:slug]

    input.merge(data: Spree::Page.find_by!(slug: slug).attributes.symbolize_keys)
  end
end

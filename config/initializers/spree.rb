# frozen_string_literal: true

Spree::Backend::Config.configure do |config|
  config.menu_items << config.class::MenuItem.new(
    [:content],
    'text-width',
    condition: -> { can?(:admin, SolidusContent::EntryType) },
    url: :admin_entry_types_path
  )
end

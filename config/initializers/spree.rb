# frozen_string_literal: true

Spree::Backend::Config.configure do |config|
  config.menu_items << config.class::MenuItem.new(
    [:entry_types, :entries],
    'text-width',
    condition: -> { can?(:admin, SolidusContent::EntryType) },
    label: :content,
    partial: 'spree/admin/shared/solidus_content_sub_menu',
    url: :admin_entry_types_path
  )
end

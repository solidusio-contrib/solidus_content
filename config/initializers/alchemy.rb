# frozen_string_literal: true

if defined?(::Alchemy)
  Alchemy.user_class_name = 'Spree::User'
  Alchemy.current_user_method = :spree_current_user
end

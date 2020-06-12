# frozen_string_literal: true

module SolidusContent
  class ResourceController < Spree::Admin::ResourceController
    private

    def collection
      super.page(params[:page] || 0)
    end

    def model_class
      "SolidusContent::#{controller_name.classify}".constantize
    end

    def new_object_url(options = {})
      new_admin_entry_type_path(options)
    end

    def edit_object_url(object, options = {})
      edit_admin_entry_type_path(object, options)
    end

    def object_url(object = nil, options = {})
      admin_entry_type_path((object || @object), options)
    end

    def collection_url(options = {})
      admin_entry_types_path(options)
    end
  end
end

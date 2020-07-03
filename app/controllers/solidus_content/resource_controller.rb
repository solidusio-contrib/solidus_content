# frozen_string_literal: true

module SolidusContent
  class ResourceController < Spree::Admin::ResourceController
    private

    def location_after_save
      edit_object_url(@object)
    end

    def collection
      super.page(params[:page] || 0)
    end

    def model_class
      "SolidusContent::#{controller_name.classify}".constantize
    end

    def new_object_url(options = {})
      send(:"new_admin_#{controller_name.singularize}_path", options)
    end

    def edit_object_url(object, options = {})
      send(:"edit_admin_#{controller_name.singularize}_path", object, options)
    end

    def object_url(object = nil, options = {})
      send(:"admin_#{controller_name.singularize}_path", object, options)
    end

    def collection_url(options = {})
      send(:"admin_#{controller_name}_path", options)
    end
  end
end

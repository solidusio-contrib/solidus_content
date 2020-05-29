# frozen_string_literal: true

module Spree
  module Admin
    class EntryTypesController < ResourceController
      helper_method :model_class

      def show
        redirect_to action: :edit
      end

      protected

      def model_class
        "SolidusContent::#{controller_name.classify}".constantize
      end

      private

      def collection
        super.page(params[:page] || 0)
      end

      def permitted_resource_params
        params.require(:solidus_content_entry_type).permit(:name, :provider_name)
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
end

# frozen_string_literal: true

module Spree
  module Admin
    class EntryTypesController < ResourceController
      def index
        respond_with(@collection)
      end

      protected

      def model_class
        "SolidusContent::#{controller_name.classify}".constantize
      end

      private

      def collection
        @collection ||= SolidusContent::EntryType.page(params[:page] || 0)
      end

      def permitted_resource_params
        params.require(:solidus_content_entry_type).permit(:name, :provider_name)
      end

      def location_after_save
        admin_entry_types_path
      end
    end
  end
end

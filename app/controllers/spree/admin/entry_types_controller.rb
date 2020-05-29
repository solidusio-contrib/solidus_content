# frozen_string_literal: true

module Spree
  module Admin
    class EntryTypesController < ResourceController
      helper_method :model_class

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

      def location_after_save
        admin_entry_types_path
      end
    end
  end
end

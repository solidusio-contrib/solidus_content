# frozen_string_literal: true

module Spree
  module Admin
    class EntryTypesController < SolidusContent::ResourceController
      helper_method :model_class

      def show
        redirect_to action: :edit
      end

      private

      def collection
        super.page(params[:page] || 0)
      end

      def location_after_save
        edit_object_url(@object)
      end

      def permitted_resource_params
        params.require(:solidus_content_entry_type)
          .permit(:name, :provider_name, *provider_params)
      end

      def provider_params
        @object.fields || []
      end
    end
  end
end

# frozen_string_literal: true

module Spree
  module Admin
    class EntryTypesController < SolidusContent::ResourceController
      helper_method :model_class

      def show
        redirect_to action: :edit
      end

      private

      def permitted_resource_params
        params
          .require(:solidus_content_entry_type)
          .permit(:name, :provider_name, *provider_params)
      end

      def provider_params
        @object.entry_type_fields || []
      end
    end
  end
end

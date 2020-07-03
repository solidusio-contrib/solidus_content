# frozen_string_literal: true

module Spree
  module Admin
    class EntriesController < SolidusContent::ResourceController
      helper_method :model_class

      def show
        redirect_to action: :edit
      end

      private

      def permitted_resource_params
        params
          .require(:solidus_content_entry)
          .permit(:slug, :entry_type_id, *provider_params)
      end

      def provider_params
        @object.entry_fields || []
      end
    end
  end
end

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

      def permitted_resource_params
        params.require(:solidus_content_entry_type).permit(:name, :provider_name, :serialized_options)
      end
    end
  end
end

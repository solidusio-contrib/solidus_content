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
        params.require(:solidus_content_entry).permit(:slub, :entry_type_id, :serialized_options)
      end
    end
  end
end

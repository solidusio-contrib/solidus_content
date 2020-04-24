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
    end
  end
end

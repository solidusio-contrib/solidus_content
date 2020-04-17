# frozen_string_literal: true

module Spree
  module Admin
    class EntryTypesController < ResourceController
      def index; end

      protected

      def model_class
        "SolidusContent::#{controller_name.classify}".constantize
      end

      private

      def collection
        @collection ||= SolidusContent::EntryType.all
      end
    end
  end
end

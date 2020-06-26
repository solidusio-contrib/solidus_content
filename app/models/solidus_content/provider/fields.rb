# frozen_string_literal: true

module SolidusContent
  module Provider
    module Fields
      def provider_based_attr_reader(attrs)
        attrs.each do |attr|
          define_singleton_method(attr) do
            options[attr.to_s] || ''
          end

          define_singleton_method("#{attr}=") do |value|
            attribute_will_change!(:options)
            options[attr.to_s] = value
          end
        end
      end
    end
  end
end

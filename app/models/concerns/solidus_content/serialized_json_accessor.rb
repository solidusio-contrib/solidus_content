module SolidusContent::SerializedJsonAccessor
  def serialized_json_accessor_for *names
    names.each do |name|
      # Rely on the database type to get options in and out of strings.
      json_serializer = ActiveRecord::Type::Json.new
      reader = :"#{name}"
      writer = :"#{name}="

      # Translates to:
      #   def serialized_options=(value)
      #     self.options = (JSON.parse(value) rescue nil)
      #   end
      define_method(:"serialized_#{name}=") do |value|
        public_send(writer, json_serializer.deserialize(value))
      end

      # Translates to:
      #   def serialized_options
      #     JSON.generate(options)
      #   end
      define_method(:"serialized_#{name}") do
        json_serializer.serialize(public_send(reader))
      end
    end
  end
end

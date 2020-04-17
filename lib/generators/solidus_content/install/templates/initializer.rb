# frozen_string_literal: true

SolidusContent.configure do |config|
  # You can control the list of content providers that will be available to the 
  # backend.
  # 
  # config.providers.delete :prismic

  # Define a custom content provider.
  # 
  # config.register_provider :data_dir, ->(input) {
  #   data = YAML.load(Rails.root.join('data', input[:slug] + '.yml').read)
  #   input.merge(data: data)
  # }

  # Set to `true` to register your own route, instead of using the default
  # that starts with `/c/`.
  # 
  # config.skip_default_route = true
end

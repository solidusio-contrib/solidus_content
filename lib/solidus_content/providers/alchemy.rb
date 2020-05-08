# frozen_string_literal: true

module SolidusContent::Providers::Alchemy
  class << self
    #
    # Load content from an AlchemyCMS page
    #
    # @param [Hash] input Hash with options.
    #
    # input[:slug] [String] :only A page urlname
    #
    # You can pass options to the element finder as well
    #
    # input[:options] [Array<String>|String] :only A list of element names to load only.
    # input[:options] [Array<String>|String] :except A list of element names not to load.
    # input[:options] [Boolean] :fixed (false) Return only fixed elements
    # input[:options] [Integer] :count The amount of elements to load
    # input[:options] [Integer] :offset The offset to begin loading elements from
    #
    # @return [<Hash>] Hash with :data holding the page attributes and elements from that page
    #
    def call(input)
      require 'alchemy_cms' unless defined?(::Alchemy)

      page = pages(input).first ||
             raise(
               ActiveRecord::RecordNotFound,
               "Page with urlname #{input[:slug]} not found!"
             )

      input.merge(
        data: page.attributes.symbolize_keys.merge(
          elements: elements_finder(input[:options]).elements(page: page),
        ),
      )
    end

    private

    def pages(input)
      Alchemy::Page.where(urlname: input.fetch(:slug)).includes(*page_includes)
    end

    def page_includes
      [
        :tags,
        {
          all_elements: [
            {
              contents: {
                essence: :ingredient_association,
              },
            },
            :tags,
          ],
        },
      ]
    end

    def elements_finder(options)
      Alchemy::ElementsFinder.new(options || {})
    end
  end
end

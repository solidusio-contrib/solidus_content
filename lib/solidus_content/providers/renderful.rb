# frozen_string_literal: true

class SolidusContent::Providers::Renderful
  attr_reader :renderful

  def initialize(renderful)
    @renderful = renderful
  end

  def call(input)
    entry_id = input.dig(:options, :id)

    input.merge(data: {
      render_in: -> (view_context) { renderful.render(entry_id, view_context: view_context) },
    })
  end
end

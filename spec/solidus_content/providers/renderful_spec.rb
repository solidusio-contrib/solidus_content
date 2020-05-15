# frozen_string_literal: true

require 'spec_helper'

require 'solidus_content/providers/renderful'

RSpec.describe SolidusContent::Providers::Renderful do
  subject(:provider) { described_class.new(renderful) }

  let(:renderful) { spy('Renderful::Client') }

  it 'creates a :render_in proc that forwards the call to Renderful' do
    result = provider.call(options: { id: 'entry_id' })

    view_context = double
    result[:data][:render_in].(view_context)

    expect(renderful).to have_received(:render).with('entry_id', view_context: view_context)
  end
end

# frozen_string_literal: true

require 'spec_helper'

RSpec.describe 'Render content with views' do
  let(:post) { create(:entry_type, name: :post, provider_name: :raw) }
  let(:view_path) { Rails.root.join('app/views/spree/solidus_content/post.html.erb') }

  before do
    view_path.dirname.mkpath

    create(:entry, slug: 'one', options: { title: 'first post' }, entry_type: post)
    create(:entry, slug: 'two', options: { title: 'second post' }, entry_type: post)

    view_path.write(%{<main><h1><%= @entry.data[:title] %></h1></main>})
  end

  after { view_path.delete }

  it 'rendering posts as views' do
    visit '/c/post/one'
    expect(page.find(:css, 'main h1')).to have_content 'first post'

    visit '/c/post/two'
    expect(page.find(:css, 'main h1')).to have_content 'second post'
  end

  context 'when the default route is disabled' do
    it 'gives 404 when the default route is disabled' do
      SolidusContent.config.skip_default_route = true
      Rails.application.reload_routes!

      expect { visit '/c/post/one' }.to raise_error(ActionController::RoutingError)

      SolidusContent.config.skip_default_route = false
      Rails.application.reload_routes!

      expect { visit '/c/post/one' }.not_to raise_error
    end
  end
end

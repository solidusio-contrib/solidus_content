require 'spec_helper'

feature 'Render content with views' do
  let(:post) { create(:entry_type, name: :post, provider_name: :raw) }
  let(:view_path) { Rails.root.join('app/views/spree/solidus_content/post.html.erb') }
  
  let!(:post_one) { create(:entry, slug: 'one', options: {title: "first post"}, entry_type: post)}
  let!(:post_two) { create(:entry, slug: 'two', options: {title: "second post"}, entry_type: post)}

  before { view_path.dirname.mkpath }
  after { view_path.delete }

  background { view_path.write(%{<main><h1><%= @data[:title] %></h1></main>}) }

  scenario 'rendering posts as views' do
    visit '/c/post/one'
    expect(page.find(:css, 'main h1')).to have_content 'first post'
    visit '/c/post/two'
    expect(page.find(:css, 'main h1')).to have_content 'second post'
  end

  context "when the default route is disabled" do
    scenario "it gives 404 when the default route is disabled" do
      SolidusContent.config.skip_default_route = true 
      Rails.application.reload_routes!
      expect {visit '/c/post/one'}.to raise_error(ActionController::RoutingError)

      SolidusContent.config.skip_default_route = false
      Rails.application.reload_routes!
      expect {visit '/c/post/one'}.not_to raise_error
    end
  end
end

# frozen_string_literal: true

require 'spec_helper'

describe 'Sidebar', :js do
  include Warden::Test::Helpers

  let(:admin_user) { create(:admin_user) }

  before do
    login_as admin_user

    visit spree.admin_path
  end

  it 'shows Content menu item in the sidebar' do
    within '[data-hook="admin_tabs"]' do
      expect(page).to have_text(I18n.t(:content, scope: %i[spree admin tab]))
    end
  end
end

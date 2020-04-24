# frozen_string_literal: true

require 'spec_helper'

describe 'Entry types', :js do
  let(:admin_user) { create(:admin_user) }

  before { login_as admin_user }

  context 'when there are not entries' do
    before { visit spree.admin_entry_types_path }

    it 'shows empty message' do
      expect(page).to have_selector('.no-objects-found')
    end
  end

  context 'when there are entries' do
    before do
      create_list(:entry_type, 30)

      visit spree.admin_entry_types_path
    end

    it 'shows pagination' do
      expect(page).to have_selector('.pagination', count: 2)
    end

    it 'shows the list of entries' do
      expect(page).to have_selector('[data-hook="admin_entry_types_index_rows"]', count: 25)
    end
  end
end

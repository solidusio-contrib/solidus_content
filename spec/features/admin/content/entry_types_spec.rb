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

  describe 'Delete entry type', :js do
    before do
      create(:entry_type)

      visit spree.admin_entry_types_path
    end

    it 'deletes entry type' do
      expect {
        accept_confirm { find('.delete-entry-type').click }
      }.to change(SolidusContent::EntryType, :count).from(1).to(0)
    end
  end

  describe 'Edit entry type', :js do
    subject { create(:entry_type) }
    before { visit spree.edit_admin_entry_type_path(subject) }

    it 'can change the options' do
      fill_in 'solidus_content_entry_type_serialized_options', with: '{"foo": "bar"}'

      expect {
        click_on 'Update'
      }.to change { SolidusContent::EntryType.last.options }.from({}).to({"foo" => "bar"})
    end
  end
end

# frozen_string_literal: true

require 'spec_helper'

RSpec.describe 'Create entry type', :js do
  let(:admin_user) { create(:admin_user) }

  before do
    login_as admin_user

    visit spree.new_admin_entry_type_path
  end

  context 'with the correct information' do
    it 'creates the entry type' do
      fill_in 'solidus_content_entry_type_name', with: 'Entry name'
      find('#solidus_content_entry_type_provider_name').find(:xpath, 'option[2]').select_option

      expect {
        click_on 'Create'
      }.to change(SolidusContent::EntryType, :count).by(1)
    end
  end

  context 'with the incorrect information' do
    it 'shows error messages' do
      expect {
        click_on 'Create'
      }.not_to change(SolidusContent::EntryType, :count)

      within '#errorExplanation' do
        expect(page).to have_text("Name can't be blank")
      end
    end
  end
end

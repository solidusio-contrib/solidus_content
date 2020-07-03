# frozen_string_literal: true

require 'spec_helper'

RSpec.describe 'Create entry', :js do
  let(:admin_user) { create(:admin_user) }
  let!(:entry_type) { create(:entry_type, provider_name: :raw) }

  before do
    login_as admin_user

    visit spree.new_admin_entry_path
  end

  context 'with the correct information' do
    it 'creates the entry type' do
      expect {
        click_on 'Create'
      }.to change(SolidusContent::Entry, :count).by(1)
      expect(SolidusContent::Entry.last.entry_type).to eq(entry_type)
    end
  end

  context 'with the incorrect information' do
    it 'shows error messages' do
      expect {
        fill_in 'solidus_content_entry_slug', with: ''
        click_on 'Create'
      }.not_to change(SolidusContent::EntryType, :count)

      within '#errorExplanation' do
        expect(page).to have_text("Slug can't be blank")
      end
    end
  end
end

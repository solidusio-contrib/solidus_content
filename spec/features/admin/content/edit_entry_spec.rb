# frozen_string_literal: true

require 'spec_helper'

RSpec.describe 'Edit entry', :js do
  let(:admin_user) { create(:admin_user) }

  let(:entry_type) { create(:entry_type, provider_name: :raw) }
  let(:entry) { create(:entry, entry_type: entry_type) }

  before { login_as admin_user }

  describe 'Edit entry type' do
    context 'when the entry type provides has fields' do
      let(:fields) { %i[date bar foo] }

      before do
        allow(SolidusContent::Providers::RAW)
          .to receive(:entry_fields).and_return(fields)

        visit spree.edit_admin_entry_path(entry)
      end

      it 'changes the option types fields' do
        fields.each do |field|
          fill_in "solidus_content_entry_#{field}", with: 'foo'
        end

        expect {
          click_on 'Update'
        }.to change { SolidusContent::Entry.last.options }.from({}).to(
          'date' => 'foo', 'bar' => 'foo', 'foo' => 'foo'
        )
      end
    end

    context 'when the entry type provides has not fields' do
      before { visit spree.edit_admin_entry_path(entry) }

      it 'does not show the option types fields' do
        expect(page).not_to have_selector('.options-form')
      end
    end
  end
end

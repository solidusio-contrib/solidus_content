# frozen_string_literal: true

require 'spec_helper'

RSpec.describe 'Edit entry type', :js do
  let(:admin_user) { create(:admin_user) }

  let(:entry_type) { create(:entry_type, provider_name: :raw) }

  before { login_as admin_user }

  describe 'Edit entry type' do
    context 'when the entry type provides has fields' do
      let(:fields) { %i[date bar foo] }

      before do
        allow(SolidusContent::Providers::RAW).to receive(:fields)
          .and_return(fields)

        visit spree.edit_admin_entry_type_path(entry_type)
      end

      it 'changes the option types fields' do
        fields.each do |field|
          fill_in "solidus_content_entry_type_#{field}", with: 'foo'
        end

        expect {
          click_on 'Update'
        }.to change { SolidusContent::EntryType.last.options }.from({}).to(
          'date' => 'foo', 'bar' => 'foo', 'foo' => 'foo'
        )
      end
    end

    context 'when the entry type provides has not fields' do
      before { visit spree.edit_admin_entry_type_path(entry_type) }

      it 'does not show the option types fields' do
        expect(page).not_to have_selector('.options-form')
      end
    end
  end
end

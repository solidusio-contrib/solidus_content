# frozen_string_literal: true

require 'spec_helper'

RSpec.describe 'Delete entry type', :js do
  let(:admin_user) { create(:admin_user) }

  before do
    login_as admin_user

    create(:entry_type)
    visit spree.admin_entry_types_path
  end

  it 'deletes entry type' do
    expect {
      accept_confirm { find('.delete-entry-type').click }
    }.to change(SolidusContent::EntryType, :count).from(1).to(0)
  end
end

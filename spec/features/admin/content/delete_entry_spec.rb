# frozen_string_literal: true

require 'spec_helper'

RSpec.describe 'Delete entry', :js do
  let(:admin_user) { create(:admin_user) }

  before do
    login_as admin_user

    create(:entry)
    visit spree.admin_entries_path
  end

  it 'deletes entry' do
    expect {
      accept_confirm { find('.delete-entry').click }
    }.to change(SolidusContent::Entry, :count).from(1).to(0)
  end
end

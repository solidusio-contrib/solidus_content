# frozen_string_literal: true

require 'spec_helper'

RSpec.describe SolidusContent::Entry do
  let(:entry) { build(:entry) }

  it 'has a valid factory' do
    expect(entry).to be_valid
  end

  specify '#data' do
    expect(entry.entry_type)
      .to receive(:content_for).with(entry) .and_return({data: :foo})
      
    expect(entry.data).to eq(:foo)
  end

  specify "#content" do
    content = double('content')

    expect(entry.entry_type)
      .to receive(:content_for).with(entry).and_return(content)

    expect(entry.content).to eq(content)
  end
end

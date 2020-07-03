# frozen_string_literal: true

require 'spec_helper'

RSpec.describe SolidusContent::Providers::Contentful do
  describe '.entry_type_fields' do
    subject { described_class.entry_type_fields }

    it { is_expected.to eq(%i[contentful_space_id contentful_access_token]) }
  end

  describe '.call' do
    subject do
      described_class.call(
        type_options: {
          contentful_space_id: contentful_space_id,
          contentful_access_token: contentful_access_token
        },
        options: {
          entry_id: entry_id
        }
      )
    end

    let(:contentful_space_id) { 'contentful_space_id' }
    let(:contentful_access_token) { 'contentful_access_token' }
    let(:entry_id) { 'entry_id' }

    let(:contentful) { instance_double(Contentful::Client) }
    let(:entry) { instance_double(Contentful::Entry) }
    let(:data) { instance_double(Hash) }

    before do
      allow(Contentful::Client)
        .to receive(:new)
        .and_return(contentful)

      allow(contentful)
        .to receive(:entry)
        .and_return(entry)

      allow(entry).to receive(:fields).and_return(data)
    end

    it 'returns data using Contentful client' do
      expect(Contentful::Client)
        .to receive(:new)
        .with(space: contentful_space_id, access_token: contentful_access_token)
        .and_return(contentful)

      expect(contentful).to receive(:entry).with(entry_id).and_return(entry)

      expect(subject[:data]).to eq(data)
    end
  end
end

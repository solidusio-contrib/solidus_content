# frozen_string_literal: true

require 'spec_helper'

RSpec.describe SolidusContent::Providers::DatoCms do
  describe '.entry_type_fields' do
    subject { described_class.entry_type_fields }

    it { is_expected.to eq(%i[api_token environment]) }
  end

  describe '.entry_fields' do
    subject { described_class.entry_fields }

    it { is_expected.to eq(%i[item_id version]) }
  end

  describe '.call' do
    subject do
      described_class.call(
        type_options: {
          api_token: api_token,
          environment: environment
        },
        options: {
          item_id: item_id,
          version: version
        }
      )
    end

    let(:api_token) { 'api_token' }
    let(:environment) { 'environment' }
    let(:item_id) { 'item_id' }
    let(:version) { 'version' }

    let!(:repo) do
      object_double(
        Dato::Site::Client.new(api_token, environment: environment).items,
        find: fields
      )
    end
    let(:fields) { instance_double(HashWithIndifferentAccess) }
    let(:dato) { object_double(Dato::Site::Client.new(api_token, environment: environment)) }

    before do
      allow(Dato::Site::Client)
        .to receive(:new)
        .and_return(dato)

      allow(dato)
        .to receive(:items)
        .and_return(repo)
    end

    it 'returns data using DatoCMS client' do
      expect(Dato::Site::Client)
        .to receive(:new)
        .with(api_token, environment: environment)
        .and_return(dato)

      expect(repo).to receive(:find).with(item_id, version: version).and_return(fields)

      expect(subject[:data]).to eq(fields)
    end
  end
end

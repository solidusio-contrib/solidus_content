# frozen_string_literal: true

require 'spec_helper'

RSpec.describe SolidusContent::Providers::Prismic do
  describe '.entry_type_fields' do
    subject { described_class.entry_type_fields }

    it { is_expected.to eq(%i[api_entry_point api_token]) }
  end

  describe '.call' do
    subject do
      described_class.call(
        type_options: type_options,
        options: {
          id: id
        }
      )
    end

    let(:api_entry_point) { 'api_entry_point' }
    let(:id) { 'id' }

    let(:prismic) { instance_double(Prismic::API) }
    let(:entry) { instance_double(Prismic::Form) }
    let(:data) { instance_double(Hash) }

    before do
      allow(::Prismic)
        .to receive(:api)
        .and_return(prismic)

      allow(prismic)
        .to receive(:getByID)
        .and_return(entry)

      allow(entry).to receive(:fields).and_return(data)
    end

    context 'when using private repository' do
      let(:api_token) { 'api_token' }

      let(:type_options) do
        {
          api_entry_point: api_entry_point,
          api_token: api_token,
        }
      end

      it 'returns data using Prismic client' do
        expect(::Prismic)
          .to receive(:api)
          .with(api_entry_point, api_token)
          .and_return(prismic)

        expect(prismic).to receive(:getByID).with(id).and_return(entry)

        expect(subject[:data]).to eq(data)
      end
    end

    context 'when using public repository' do
      let(:type_options) do
        {
          api_entry_point: api_entry_point
        }
      end

      it 'returns data using Prismic client' do
        expect(::Prismic)
          .to receive(:api)
          .with(api_entry_point, nil)
          .and_return(prismic)

        expect(prismic).to receive(:getByID).with(id).and_return(entry)

        expect(subject[:data]).to eq(data)
      end
    end
  end
end

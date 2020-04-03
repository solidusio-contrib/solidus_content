# frozen_string_literal: true

require 'spec_helper'

RSpec.describe SolidusContent::ContentProviders::Prismic do
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

    let(:prismic) { double('Prismic') }
    let(:entry) { double('Prismic::API') }
    let(:data) { double('Hash') }

    before do
      allow(::Prismic)
        .to receive(:api)
        .and_return(prismic)

      allow(prismic)
        .to receive(:getByID)
        .and_return(entry)

      allow(entry).to receive(:fields).and_return(data)
    end

    context 'using private repository' do
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

    context 'using public repository' do
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

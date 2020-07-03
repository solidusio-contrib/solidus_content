# frozen_string_literal: true

require 'spec_helper'

RSpec.describe SolidusContent::Providers::SolidusStaticContent do
  let(:page) { create(:page) }

  describe '.fields' do
    subject { described_class.fields }

    it { is_expected.to eq(%i[]) }
  end

  context 'when passing the slug in the options' do
    it 'returns static content data' do
      expect(
        described_class.call(slug: page.slug)[:data]
      ).to eq(page.reload.attributes.symbolize_keys)
    end
  end

  context 'when using the entry slug' do
    it 'returns static content data' do
      expect(
        described_class.call(
          slug: page.slug,
          options: {
            slug: page.slug
          }
        )[:data]
      ).to eq(page.reload.attributes.symbolize_keys)
    end
  end
end

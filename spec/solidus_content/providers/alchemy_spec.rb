# frozen_string_literal: true

require 'spec_helper'
require 'generators/alchemy/install/install_generator'
require 'alchemy/test_support/factories/element_factory'

RSpec.describe SolidusContent::Providers::Alchemy do
  let!(:element) { create(:alchemy_element, page: page) }
  let(:page) { create(:alchemy_page) }

  before(:all) do
    Alchemy::Generators::InstallGenerator.start(['--skip-demo-files', '--skip', '--quiet'])
  end

  context 'passing the slug in the options' do
    context 'for an existing page' do
      it 'returns page attributes plus elements' do
        expect(
          described_class.call(slug: page.urlname)[:data]
        ).to eq(page.attributes.symbolize_keys.merge(elements: page.elements))
      end

      context 'and passing element names in the options' do
        let!(:header) { create(:alchemy_element, name: 'header', page: page) }

        it 'returns only elements having that name' do
          expect(
            described_class.call(slug: page.urlname, options: { only: 'header' })[:data][:elements]
          ).to eq(page.elements.named('header'))
        end
      end

      context 'and passing element names in the options to exclude' do
        let!(:header) { create(:alchemy_element, name: 'header', page: page) }

        it 'returns only elements having that name' do
          expect(
            described_class.call(slug: page.urlname, options: { except: 'header' })[:data][:elements]
          ).to eq(page.elements.named('article'))
        end
      end
    end

    context 'for an unknown page' do
      it 'raises not found error' do
        expect {
          described_class.call(slug: 'not/known')
        }.to raise_error('Page with urlname not/known not found!')
      end
    end
  end
end

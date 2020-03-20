# frozen_string_literal: true

require 'spec_helper'

RSpec.describe SolidusContent::Configuration do
  subject(:configuration) { described_class.new }

  describe '#content_providers' do
    context 'without a configuration' do
      it 'is an empty hash' do
        expect(configuration.content_providers).to eq(Hash.new)
      end
    end

    context 'with a configuration' do
      let(:foo_content_provider) { double(:foo_content_provider) }
      before { configuration.content_providers[:foo] = foo_content_provider }

      context 'asking for an existing configuration' do
        it 'returns the configuration' do
          expect(configuration.content_providers[:foo]).to eq(foo_content_provider)
        end
      end

      context 'asking for a not existing configuration' do
        it 'returns the configuration' do
          expect { configuration.content_providers[:bar] }
            .to raise_error(
              SolidusContent::Configuration::UnknownProvider,
              "Can't find a provider for :bar"
            )
        end
      end
    end
  end
end

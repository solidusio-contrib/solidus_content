# frozen_string_literal: true

require 'spec_helper'

RSpec.describe SolidusContent::Configuration do
  subject(:configuration) { described_class.new }

  describe '#providers' do
    context 'without a configuration' do
      it 'is an empty hash' do
        expect(configuration.providers).to eq({})
      end
    end

    context 'with a configuration' do
      let(:foo_provider) { double(:foo_provider) }

      before { configuration.providers[:foo] = foo_provider }

      context 'when asking for an existing configuration' do
        it 'returns the configuration' do
          expect(configuration.providers[:foo]).to eq(foo_provider)
        end
      end

      context 'when asking for a not existing configuration' do
        it 'returns the configuration' do
          expect { configuration.providers[:bar] }
            .to raise_error(
              SolidusContent::Configuration::UnknownProvider,
              "Can't find a provider for :bar"
            )
        end
      end
    end
  end
end

# frozen_string_literal: true

require 'spec_helper'

RSpec.describe SolidusContent do
  describe '.configure' do
    it 'yields the configuration' do
      expect { |b| described_class.configure(&b) }.to yield_with_args(described_class.config)
    end
  end

  describe '.config' do
    it 'returns an instance of SolidusContent::Config' do
      expect(described_class.config).to be_instance_of(SolidusContent::Configuration)
    end
  end
end

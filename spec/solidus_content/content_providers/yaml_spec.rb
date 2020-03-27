# frozen_string_literal: true

require 'spec_helper'

RSpec.describe SolidusContent::ContentProviders::YAML do
  let(:path) { File.absolute_path('content', FIXTURE_PATH) }

  context "when the yml extension isn't available" do
    it "uses the yaml extension" do
      expect(described_class.call(
        slug: 'example_2',
        type_options: { path: path },
      )[:data]).to eq(foo: 'yaml_bar')
    end
  end

  context "when both yml and yaml extensions are available" do
    it "uses the yml one" do
      expect(described_class.call(
        slug: 'example',
        type_options: { path: path },
      )[:data]).to eq(foo: 'yml_bar')
    end
  end

  context "with an absolute path" do
    it "uses the absolute path as is" do
      expect(described_class.call(
        slug: 'example',
        type_options: { path: path },
      )[:data]).to eq(foo: 'yml_bar')
    end
  end

  context "with a relative path" do
    before { allow(Rails).to receive(:root).and_return(Pathname(FIXTURE_PATH)) }

    it "uses the absolute path as is" do
      expect(described_class.call(
        slug: 'example',
        type_options: { path: 'content' },
      )[:data]).to eq(foo: 'yml_bar')
    end
  end
end

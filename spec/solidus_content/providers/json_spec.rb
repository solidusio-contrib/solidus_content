# frozen_string_literal: true

require 'spec_helper'

RSpec.describe SolidusContent::Providers::JSON do
  context "with an absolute path" do
    let(:path) { File.absolute_path('content', FIXTURE_PATH) }

    it "uses the absolute path as is" do
      expect(described_class.call(
        slug: 'example',
        type_options: { path: path },
      )[:data]).to eq(foo: 'json_bar')
    end
  end

  context "with a relative path" do
    before { allow(Rails).to receive(:root).and_return(Pathname(FIXTURE_PATH)) }

    it "uses the absolute path as is" do
      expect(described_class.call(
        slug: 'example',
        type_options: { path: 'content' },
      )[:data]).to eq(foo: 'json_bar')
    end
  end
end

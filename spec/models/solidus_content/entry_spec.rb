# frozen_string_literal: true

require "spec_helper"

RSpec.describe SolidusContent::Entry do
  let(:entry) { build(:entry) }

  it "has a valid factory" do
    expect(entry).to be_valid
  end

  describe ".data_for" do
    let(:post) { create(:entry_type, name: :post, provider_name: :raw) }
    let!(:post_one) do
      create(:entry,
        slug: "one",
        options: { title: "first post" },
        entry_type: post
      )
    end

    context "with using correct type and slug" do
      it "returns data" do
        expect(
          SolidusContent::Entry.data_for(:post, "one")
        ).to eq({title: "first post"})
      end
    end

    context "with using invalid type" do
      it "will raise an ActiveRecord::RecordNotFound exception" do
        expect{
          SolidusContent::Entry.data_for(:foo, "one")
        }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end

    context "with using an invalid slug" do
      it "will raise an ActiveRecord::RecordNotFound exception" do
        expect{
          SolidusContent::Entry.data_for(:post, "foo")
        }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end

  specify "#data" do
    expect(entry.entry_type)
      .to receive(:content_for).with(entry).and_return({data: :foo})

    expect(entry.data).to eq(:foo)
  end

  specify "#content" do
    content = double("content")

    expect(entry.entry_type)
      .to receive(:content_for).with(entry).and_return(content)

    expect(entry.content).to eq(content)
  end
end

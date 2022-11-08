# frozen_string_literal: true

require "spec_helper"

RSpec.describe SolidusContent::Entry do
  let(:entry) { build(:entry) }

  let(:post) { create(:entry_type, name: :post, provider_name: :raw) }
  let(:home) { create(:entry_type, name: :home, provider_name: :raw) }

  let!(:post_one) do
    create(
      :entry,
      slug: "one",
      options: { title: "first post" },
      entry_type: post
    )
  end

  let!(:home_default) do
    create(
      :entry,
      slug: :default,
      options: { title: "Homepage" },
      entry_type: home
    )
  end

  it "has a valid factory" do
    expect(entry).to be_valid
  end

  describe ".data_for" do
    context "with using correct type and slug" do
      it "returns the stored data" do
        expect(
          described_class.data_for(:post, "one")
        ).to eq(title: "first post")
      end
    end

    context "with using invalid type" do
      it "will raise an ActiveRecord::RecordNotFound exception" do
        expect{
          described_class.data_for(:foo, "one")
        }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end

    context "with using an invalid slug" do
      it "will raise an ActiveRecord::RecordNotFound exception" do
        expect{
          described_class.data_for(:post, "foo")
        }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end

  describe ".by_type" do
    context "with entry_type present" do
      context "with symbol passed in for type" do
        it "returns the correct Entries" do
          expect(described_class.by_type(:post)).to include post_one
          expect(described_class.by_type(:post)).not_to include home_default
        end
      end

      context "with EntryType instance passed in for type" do
        it "returns the correct Entries" do
          expect(described_class.by_type(post)).to include post_one
          expect(described_class.by_type(post)).not_to include home_default
        end
      end
    end

    context "with using invalid type" do
      it "will raise an ActiveRecord::RecordNotFound exception" do
        expect{
          described_class.by_type(:foo)
        }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end

  specify "#data" do
    allow(entry.entry_type)
      .to receive(:content_for).with(entry).and_return(data: :foo)

    expect(entry.data).to eq(:foo)
  end

  specify "#content" do
    content = instance_double(Hash)

    allow(entry.entry_type)
      .to receive(:content_for).with(entry).and_return(content)

    expect(entry.content).to eq(content)
  end
end

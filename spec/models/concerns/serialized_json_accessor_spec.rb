require 'spec_helper'

RSpec.describe SolidusContent::SerializedJsonAccessor do
  let(:model) {
    Class.new do
      include ActiveModel::Model
      attr_accessor :foo

      extend SolidusContent::SerializedJsonAccessor
      serialized_json_accessor_for :foo
    end.new
  }

  it 'proxies JSON attributes allowing them to be written and read as strings' do
    model.serialized_foo = '{}'
    expect(model.serialized_foo).to eq('{}')
    expect(model.foo).to eq({})

    model.serialized_foo = '{  "foo"  : 123 }'
    expect(model.serialized_foo).to eq('{"foo":123}')
    expect(model.foo).to eq("foo" => 123)

    model.foo = {}
    expect(model.serialized_foo).to eq('{}')
    expect(model.foo).to eq({})

    model.foo = {"foo" => 123}
    expect(model.serialized_foo).to eq('{"foo":123}')
    expect(model.foo).to eq("foo" => 123)
  end
end

require "test_helper"

describe Client do
  let(:client) { Client.new }

  it "must be valid" do
    value(client).must_be :valid?
  end
end

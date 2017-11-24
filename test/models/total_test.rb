require "test_helper"

describe Total do
  let(:total) { Total.new }

  it "must be valid" do
    value(total).must_be :valid?
  end
end

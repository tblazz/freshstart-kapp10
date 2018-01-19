require "test_helper"

describe Score do
  let(:total) { Score.new }

  it "must be valid" do
    value(total).must_be :valid?
  end
end

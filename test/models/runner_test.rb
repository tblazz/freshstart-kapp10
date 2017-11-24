require "test_helper"

describe Runner do
  let(:runner) { Runner.new }

  it "must be valid" do
    value(runner).must_be :valid?
  end
end

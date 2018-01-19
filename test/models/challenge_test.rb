require "test_helper"

describe Challenge do
  let(:challenge) { Challenge.new }

  it "must be valid" do
    value(challenge).must_be :valid?
  end
end

# == Schema Information
#
# Table name: challenges
#
#  id         :integer          not null, primary key
#  name       :string
#  widget     :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require "test_helper"

describe Challenge do
  let(:challenge) { Challenge.new }

  it "must be valid" do
    value(challenge).must_be :valid?
  end
end

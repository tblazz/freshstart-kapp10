# == Schema Information
#
# Table name: scores
#
#  id         :integer          not null, primary key
#  runner_id  :integer
#  race_id    :uuid             not null
#  points     :integer
#  race_type  :string
#  date       :datetime
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require "test_helper"

describe Score do
  let(:total) { Score.new }

  it "must be valid" do
    value(total).must_be :valid?
  end
end

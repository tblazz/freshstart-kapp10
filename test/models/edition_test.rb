# == Schema Information
#
# Table name: editions
#
#  id          :integer          not null, primary key
#  date        :date
#  description :string
#  event_id    :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

require "test_helper"

describe Edition do
  let(:edition) { Edition.new }

  it "must be valid" do
    value(edition).must_be :valid?
  end
end

# == Schema Information
#
# Table name: runners
#
#  id         :integer          not null, primary key
#  id_key     :string
#  first_name :string
#  last_name  :string
#  dob        :datetime
#  department :string
#  sex        :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  category   :string
#

require "test_helper"

describe Runner do
  let(:runner) { Runner.new }

  it "must be valid" do
    value(runner).must_be :valid?
  end
end

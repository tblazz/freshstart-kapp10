# == Schema Information
#
# Table name: events
#
#  id               :integer          not null, primary key
#  name             :string
#  place            :string
#  website          :string
#  facebook         :string
#  twitter          :string
#  instagram        :string
#  contact          :string
#  email            :string
#  phone            :string
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  client_1         :integer
#  client_2         :integer
#  client_3         :integer
#  department       :string
#  challenge_id     :integer
#  global_challenge :boolean
#

require "test_helper"

describe Event do
  let(:event) { Event.new }

  it "must be valid" do
    value(event).must_be :valid?
  end
end

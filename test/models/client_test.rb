# == Schema Information
#
# Table name: clients
#
#  id             :integer          not null, primary key
#  name           :string
#  results_widget :string
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

require "test_helper"

describe Client do
  let(:client) { Client.new }

  it "must be valid" do
    value(client).must_be :valid?
  end
end

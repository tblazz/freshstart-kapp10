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

FactoryGirl.define do
  factory :client do
    name "MyString"
    results_widget "MyString"
  end
end

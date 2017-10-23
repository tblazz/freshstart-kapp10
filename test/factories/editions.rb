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

FactoryGirl.define do
  factory :edition do
    date "2017-10-20"
    description "MyString"
    event_id 1
  end
end

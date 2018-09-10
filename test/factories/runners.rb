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

FactoryGirl.define do
  factory :runner do
    id_key "MyString"
    first_name "MyString"
    last_name "MyString"
    dob "2017-11-16 11:05:06"
    department "MyString"
    sex "MyString"
  end
end

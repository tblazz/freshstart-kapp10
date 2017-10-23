# == Schema Information
#
# Table name: events
#
#  id         :integer          not null, primary key
#  name       :string
#  place      :string
#  website    :string
#  facebook   :string
#  twitter    :string
#  instagram  :string
#  contact    :string
#  email      :string
#  phone      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

RSpec.describe Event, type: :model do
  it { should have_many(:editions) }
  it { should have_many(:races) }
  it { should validate_presence_of(:name) }
  it { should validate_length_of(:name).is_at_least(2) }
  it { should validate_length_of(:name).is_at_most(30) }
  it { should validate_presence_of(:place) }
  it { should validate_length_of(:place).is_at_least(2) }
  it { should validate_length_of(:place).is_at_most(30) }
  it { should validate_presence_of(:contact) }
  it { should validate_presence_of(:email) }
end

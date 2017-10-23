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

require 'rails_helper'

RSpec.describe Edition, type: :model do
  it { should belong_to(:event) }
  it { should validate_presence_of(:date) }
  it { should validate_presence_of(:description) }
end

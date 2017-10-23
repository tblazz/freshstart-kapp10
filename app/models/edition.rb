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

class Edition < ApplicationRecord
  # Relations
  belongs_to :event
  has_many :races

  # Validations
  validates :event_id, presence: true
  validates :date, presence: true
  validates :description, presence: true
end

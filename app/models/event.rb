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

class Event < ApplicationRecord
  # Relations
  has_many :editions
  has_many :races, through: :editions

  # Validations
  validates :name, presence: true, length: { in: 2..30 }
  validates :place, presence: true, length: { in: 2..30 }
  validates :contact, presence: true
  validates :email, presence: true, format: { with: /\A[^@]+@([^@\.]+\.)+[^@\.]+\z/ }
end

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

  def self.import(file)
    CSV.foreach(file.path, col_sep: ';', row_sep: :auto, headers: true) do |row|
      p row
      Event.create(name: row[0],
                   place: row[1],
                   website: row[2],
                   facebook: row[3],
                   twitter: row[4],
                   instagram: row[5],
                   contact: row[6],
                   email: row[7],
                   phone: row[8])
    end
  end
end

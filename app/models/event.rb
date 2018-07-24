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

class Event < ApplicationRecord
  # Relations
  has_many :editions
  has_many :races, through: :editions
  belongs_to :challenge

  # Validations
  validates :name, presence: true, length: { in: 2..50 }
  # validates :place, presence: true, length: { in: 2..30 }
  # validates :contact, presence: true
  # validates :email, presence: true, format: { with: /\A[^@]+@([^@\.]+\.)+[^@\.]+\z/ }

  # Scopes
  scope :with_client, ->(client_id) { where('client_1=? OR client_2=? OR client_3=?', client_id, client_id, client_id) }

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

  def clients
    c = []
    c << Client.find(client_1) unless client_1.blank?
    c << Client.find(client_2) unless client_2.blank?
    c << Client.find(client_3) unless client_3.blank?
    c.compact
  end
end

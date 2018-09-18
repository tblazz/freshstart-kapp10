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

class Runner < ApplicationRecord
  # Relations
  has_many :results
  has_many :scores
  has_many :photos

  # Validations
  validates :first_name, presence: true, length: { in: 2..30 }
  validates :last_name, presence: true, length: { in: 2..30 }
  validates :dob, presence: true
  validates :id_key, uniqueness: true
  validates :sex, inclusion: { in: %w(M F) }, allow_nil: true

  after_validation :generate_id_key, on: :create

  # Scopes
  scope :with_name, -> (q) { where("lower(last_name) LIKE ? OR lower(first_name) LIKE ?", "%#{q.downcase}%", "%#{q.downcase}%") }

  def results_in_global_challenge
    events = Event.where(global_challenge: true)
    results.select { |r| events.map(&:editions).to_a.flatten.include?(r.edition) }.count
  end

  private
  
  def generate_id_key
    id_key = "#{I18n.transliterate(first_name).downcase}-#{I18n.transliterate(last_name).downcase}-#{dob.strftime('%d-%m-%Y')}"
  end
end

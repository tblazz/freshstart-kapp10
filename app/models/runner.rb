class Runner < ApplicationRecord
  # Relations
  has_many :results
  has_many :scores

  # Validations
  validates :first_name, presence: true, length: { in: 2..30 }
  validates :last_name, presence: true, length: { in: 2..30 }
  validates :dob, presence: true
  validates :id_key, uniqueness: true
  validates :sex, inclusion: { in: %w(M F) }, allow_nil: true

  after_validation :generate_id_key, on: :create
  
  private
  def generate_id_key
    id_key = "#{I18n.transliterate(first_name).downcase}-#{I18n.transliterate(last_name).downcase}-#{dob.strftime('%d-%m-%Y')}"
  end
end

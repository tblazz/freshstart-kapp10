class Runner < ApplicationRecord
  # Relations
  has_many :results

  # Validations
  validates :first_name, presence: true, length: { in: 2..30 }
  validates :last_name, presence: true, length: { in: 2..30 }
  validates :dob, presence: true
  validates :id_key, presence: true, uniqueness: true
  validates :sex, inclusion: { in: %w(M F) }, allow_nil: true

  before_validation :create_id_key
  
  private
  def create_id_key
    if self.id_key.blank?
      self.id_key = "#{I18n.transliterate(first_name).downcase}-#{I18n.transliterate(last_name).downcase}-#{dob.strftime('%d-%m-%Y')}"
    end
  end
end

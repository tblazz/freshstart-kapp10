class Score < ApplicationRecord
  # Relations
  belongs_to :runner
  belongs_to :race
  delegate :last_name, to: :runner

  # Validations
  validates :points, presence: true
  validates :race_type, inclusion: { in: ['trail', 'route', 'funrace'] }

  # Scopes
end

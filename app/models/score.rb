# == Schema Information
#
# Table name: scores
#
#  id         :integer          not null, primary key
#  runner_id  :integer
#  race_id    :uuid             not null
#  points     :integer
#  race_type  :string
#  date       :datetime
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

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

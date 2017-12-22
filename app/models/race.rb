# == Schema Information
#
# Table name: races
#
#  id                            :uuid             not null, primary key
#  name                          :string
#  email_sender                  :string
#  email_name                    :string
#  date                          :date
#  hashtag                       :string
#  results_url                   :string
#  sms_message                   :string
#  created_at                    :datetime         not null
#  updated_at                    :datetime         not null
#  raw_results_file_name         :string
#  raw_results_content_type      :string
#  raw_results_file_size         :integer
#  raw_results_updated_at        :datetime
#  background_image_file_name    :string
#  background_image_content_type :string
#  background_image_file_size    :integer
#  background_image_updated_at   :datetime
#  template                      :string
#  widget_generated_at           :datetime
#  photos_widget_generated_at    :datetime
#  external_link                 :string
#  external_link_button          :string
#  edition_id                    :integer
#  coef                          :integer
#  category                      :string
#  department                    :string
#  race_type                     :string
#

class Race < ActiveRecord::Base
  # has_attached_file :raw_results
  # has_attached_file :background_image, styles: { medium: "300x300", standard: "1024x1024" }

  # Relations
  # has_many :results, dependent: :destroy
  # has_many :photos


  belongs_to :edition
  has_many :scores
  has_many :runners, through: :scores
  has_many :results
  has_many :photos

  delegate :event, to: :edition, allow_nil: true

  #
  #
  # # Validations
  # validates_attachment_content_type :raw_results, :content_type => ["text/plain", "text/csv", "application/vnd.ms-excel", "text/comma-separated-values",  Paperclip::ContentTypeDetector::SENSIBLE_DEFAULT]
  # validates_attachment_content_type :background_image, content_type: /\Aimage\/.*\z/
  # validates_presence_of :name, :date, :template
  # validates :date, uniqueness: { scope: :name }


  validates :race_type, inclusion: { in: ['trail', 'route', 'funrace'] }

end

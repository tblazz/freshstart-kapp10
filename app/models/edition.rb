# == Schema Information
#
# Table name: editions
#
#  id                            :integer          not null, primary key
#  date                          :date
#  description                   :string
#  event_id                      :integer
#  email_sender                  :string
#  email_name                    :string
#  hashtag                       :string
#  results_url                   :string
#  sms_message                   :string
#  template                      :string
#  widget_generated_at           :datetime
#  photos_widget_generated_at    :datetime
#  external_link                 :string
#  external_link_button          :string
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
#

class Edition < ApplicationRecord
  # Relations
  belongs_to :event
  has_many :races
  has_many :results, dependent: :destroy
  has_many :photos
  has_many :runners, through: :results

  has_attached_file :raw_results
  has_attached_file :background_image, styles: { medium: "300x300", standard: "1024x1024" }

  # Validations
  validates :event_id, presence: true
  validates_attachment_content_type :raw_results, :content_type => ["text/plain", "text/csv", "application/vnd.ms-excel", "text/comma-separated-values",  Paperclip::ContentTypeDetector::SENSIBLE_DEFAULT]
  validates_attachment_content_type :background_image, content_type: /\Aimage\/.*\z/
  validates_presence_of :date, :template, :description


  TEMPLATES = Dir.glob("#{Rails.root}/app/views/diploma/*.html.erb").map{|template| template.split('/').last}.map{|template| template.gsub('.html.erb','')}
  # ['template1', 'texte-ombre']

  before_save do |race|
    self.sms_message = I18n.t('sms_message_template') if self.sms_message.blank?
  end

  def runners_count
    @runners_count ||= results.count
  end

  def races_count
    @races_count ||= results.select(:race_detail).distinct.count
  end

  def race_detail
    @races ||= results.select(:race_detail).distinct.pluck(:race_detail)
  end

  def emails_count
    @emails_count ||= results.pluck(:mail).select{|mail| mail =~ MAIL_REGEX}.length
  end

  def phones_count
    @phones_count ||= results.pluck(:phone).select{|phone| phone =~ PHONE_REGEX}.length
  end

  def widget_storage_name
    "results/#{self.date.year}/#{self.date.month}/#{self.id}"
  end

  def photos_widget_storage_name
    "photos/#{self.date.year}/#{self.date.month}/photos_#{self.id}"
  end

  def widget_url
    "https://<%= #{ENV['AWS_S3_HOST_NAME_REGION']}.amazonaws.com/#{ENV['S3_WIDGET_BUCKET']}/#{widget_storage_name}"
  end

  def photos_widget_url
    "https://<%= #{ENV['AWS_S3_HOST_NAME_REGION']}.amazonaws.com/#{ENV['S3_WIDGET_BUCKET']}/#{photos_widget_storage_name}"
  end

  def widget_gist
    %(
	<iframe class='kapp10-embed' src="//<%= #{ENV['AWS_S3_HOST_NAME_REGION']}.amazonaws.com/#{ENV['S3_WIDGET_BUCKET']}/#{widget_storage_name}" frameborder="0" scrolling="no" frameborder="0" allowfullscreen="" style="border: none; width: 1px; min-width: 100%; *width: 100%; height: 100%; min-height: 1100px;" scrolling="no"></iframe>)
  end

  def photos_widget_gist
    %(
			<iframe class='kapp10-embed' src="//<%= #{ENV['AWS_S3_HOST_NAME_REGION']}.amazonaws.com/#{ENV['S3_WIDGET_BUCKET']}/#{photos_widget_storage_name}" frameborder="0" scrolling="no" frameborder="0" allowfullscreen="" style="border: none; width: 1px; min-width: 100%; *width: 100%; height: 100%; min-height: 1000px;" scrolling="no"></iframe>)
  end

  def generate_diplomas
    results.where("diploma_generated_at < uploaded_at or diploma_generated_at is null").pluck(:id).each do |id|
      GenerateDiplomaJob.perform_later(id)
    end
  end

  def delete_diplomas
    results.each do |result|
      result.diploma = nil
      result.generated_at = nil
      result.save
    end
  end
end

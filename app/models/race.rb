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
#

class Race < ActiveRecord::Base
  has_attached_file :raw_results
  has_attached_file :background_image, styles: { medium: "300x300", standard: "1024x1024" }
  has_many :results, dependent: :destroy
  validates_attachment_content_type :raw_results, :content_type => ["text/plain", "text/csv", "application/vnd.ms-excel", "text/comma-separated-values",  Paperclip::ContentTypeDetector::SENSIBLE_DEFAULT]
  validates_attachment_content_type :background_image, content_type: /\Aimage\/.*\z/
  validates_presence_of :name, :date, :template

  TEMPLATES = Dir.glob("#{Rails.root}/app/views/diploma/*.html.erb").map{|template| template.split('/').last}.map{|template| template.gsub('.html.erb','')}
  # ['template1', 'texte-ombre']

  before_save do |race|
    self.sms_message = I18n.t('sms_message_template') if self.sms_message.blank?
  end

  def runners_count
    @runners_count ||= results.count
  end

  def races_count
    @races_count ||= results.select(:race_detail).uniq.count
  end

  def races
    @races ||= results.select(:race_detail).uniq.pluck(:race_detail)
  end

  def emails_count
    @emails_count ||= results.pluck(:mail).select{|mail| mail =~ MAIL_REGEX}.length
  end

  def phones_count
    @phones_count ||= results.pluck(:phone).select{|phone| phone =~ PHONE_REGEX}.length
  end

  def widget_storage_name
    "#{self.date.year}/#{self.date.month}/#{self.id}"
  end

  def widget_url
    "https://s3-eu-west-1.amazonaws.com/results-widget.kapp10.com/#{widget_storage_name}"
  end

  def widget_gist
    %(
<script async src="//s3-eu-west-1.amazonaws.com/results-widget.kapp10.com/widget.js" charset="utf-8"></script>
<iframe class='kapp10-embed' src="//s3-eu-west-1.amazonaws.com/results-widget.kapp10.com/#{widget_storage_name}" frameborder="0" scrolling="no" frameborder="0" allowfullscreen="" style="border: none; width: 100%"></iframe>)
  end

  def generate_diplomas
    results.where("diploma_generated_at < uploaded_at or diploma_generated_at is null").pluck(:id).each do |id|
      GenerateDiplomaJob.perform_later(id)
    end
  end
end

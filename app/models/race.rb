class Race < ActiveRecord::Base
  has_attached_file :raw_results
  has_attached_file :background_image, styles: { medium: "300x300", standard: "1024x1024" }
  has_many :results, dependent: :destroy
  validates_attachment_content_type :raw_results, :content_type => ["text/plain", "text/csv"]
  validates_attachment_content_type :background_image, content_type: /\Aimage\/.*\z/


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

  def widget_gist
    %(
<script async src="//results-widget.kapp10.com.s3.amazonaws.com/widget.js" charset="utf-8"></script>
<iframe class='kapp10-embed' src="//results-widget.kapp10.com.s3.amazonaws.com/#{widget_storage_name}" frameborder="0" scrolling="no" frameborder="0" allowfullscreen="" style="border: none; width: 100%"></iframe>)
  end
end

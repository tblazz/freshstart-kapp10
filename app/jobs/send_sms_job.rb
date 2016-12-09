require 'csv'

class SendSmsJob < ActiveJob::Base
  queue_as :normal

  def perform(name, time, race_name_mail, phone_number, rank, results_url, sms_message, short_image_path, campain_name)
    #on réduit le nom à 40 caractère max. si besoin
    name = name[0, SMS_MAX_NAME_LENGHT] + '.' if name.size > SMS_MAX_NAME_LENGHT
    message = sms_message % { name: name, time: time, url: short_image_path, race_name_mail: race_name_mail,rank: rank, results_url: results_url}
    payload = I18n.t 'sms_payload',race_name_mail: race_name_mail, campain_name: campain_name, message: message, sender_name: SENDER_SMS, phone_number: phone_number
    url = URI.parse(SMS_PATH)
    req = Net::HTTP::Post.new(url.path)
    req.set_form_data({'login' => SMS_LOGIN, 'apiKey' => SMS_API_KEY, 'smsData' => payload}, '&')
    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true
    http.start { |http| http.request(req) }
  end
end
require 'csv'

class SendSmsJob < ActiveJob::Base
  queue_as :default

  def perform(name, time, phone_number, short_image_path, campain_name)
    #on réduit le nom à 40 caractère max. si besoin
    name = name[0, SMS_MAX_NAME_LENGHT] + '.' if name.size > SMS_MAX_NAME_LENGHT
    message = I18n.t 'sms_message_template', name: name, time: time, url: short_image_path
    sms_path = SMS_PATH % {message: message, phone_number: phone_number, sender_name: SENDER_SMS, campain_name: campain_name}
    HTTParty.get(sms_path)
  end
end
require 'csv'

class SendMessengerMessageJob < ActiveJob::Base
  queue_as :normal

  def perform(name, time, race_name_mail, phone_number, image_path)
    #on réduit le nom à 40 caractère max. si besoin
    name = name[0, SMS_MAX_NAME_LENGHT] + '.' if name.size > SMS_MAX_NAME_LENGHT
    message = I18n.t 'messenger_message_template', name: name, time: time, race_name_mail: race_name_mail
    MessengerHandler.send_sms(phone_number, message)
    MessengerHandler.send_mms(phone_number, MMS_TYPE_IMAGE, image_path)
  end
end
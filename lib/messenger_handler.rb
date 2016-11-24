# messenger_handler.rb
# Created by Edouard Brèthes on 05/09/16,
# This code is property from L'Apptelier SARL.
# noinspection RailsChecklist05
class MessengerHandler

  def self.send_sms(phone_number, text)
    begin
      json = JSON.parse("{\"recipient\":{\"phone_number\":\"#{phone_number}\"},\"message\":{\"text\":\"#{text}\"}}")
      Rails.logger.info("json to send = #{json.inspect}")
      delivery = MessageQuickly::Api::Messages.create_from_hash(json)
      Rails.logger.info("delivery #{delivery.inspect}")
    rescue => exception
      Rails.logger.error(exception.inspect)
    end
  end

  def self.send_mms(phone_number, media_type, payload)
    begin
      json = JSON.parse("{\"recipient\":{\"phone_number\":\"#{phone_number}\"},\"message\":{\"attachment\":{\"type\":\"#{media_type}\",\"payload\":{\"url\":\"#{payload}\",\"is_reusable\":false}}}}")
      Rails.logger.info("json to send = #{json.inspect}")
      delivery = MessageQuickly::Api::Messages.create_from_hash(json)
      Rails.logger.info("delivery #{delivery.inspect}")
    rescue => exception
      Rails.logger.error(exception.inspect)
    end
  end

  #send a ... bubble to the user, mimicing typing
  def self.send_waiting_message(recipient_id)
    message = {}
    message['recipient'] = {}
    message['recipient']['id'] = recipient_id
    message['sender_action'] = 'typing_on'
    delivery = MessageQuickly::Api::Messages.create_from_hash(message)
    Rails.logger.info(delivery.inspect)
  end

  #send a message to the given recipient id
  def self.send_text_message(key, recipient_id, options = {})
    begin
      if recipient_id
        recipient = MessageQuickly::Messaging::Recipient.new(id: recipient_id)
        text = I18n.t(key, options)
        if options[:quick_replies]
          quick_replies_t = []
          options[:quick_replies].each do |quick_reply|
            if quick_reply.eql? LOCATION
              quick_replies_t.push(MessengerHandler.quick_reply_location)
            else
              quick_replies_t.push(MessengerHandler.quick_reply(quick_reply, options))
            end
          end
          json = JSON.parse("{\"recipient\":{\"id\":\"#{recipient_id}\"},\"message\":{\"text\":\"#{text}\",\"quick_replies\":#{quick_replies_t.to_json}}}")
          Rails.logger.info("json to send = #{json.inspect}")
          delivery = MessageQuickly::Api::Messages.create_from_hash(json)
        else
          delivery = MessageQuickly::Api::Messages.create(recipient) do |message|
            message.text = text
          end
        end
        Rails.logger.info(delivery.inspect)
      else

      end
    rescue => exception
      Rails.logger.error(exception.inspect)
      #si utilisateur ne recevant plus de message, on vire son profil
      if exception.is_a?(MessageQuickly::Api::OauthException) && exception.message.eql?("(#100) No matching user found")
        user = User.find_by(token: recipient_id)
        user.destroy if user
        Rails.logger.info("MESSENGER : user configuration destroyed")
      end
    end
  end

  #send an image to the given recipient id
  def self.send_image(image_url, recipient_id)
    begin
      Rails.logger.info("image url to send = #{image_url.inspect}")
      recipient = MessageQuickly::Messaging::Recipient.new(id: recipient_id)
      delivery = MessageQuickly::Api::Messages.create(recipient) do |message|
        message.build_attachment(:image) { |attachment| attachment.url = image_url }
      end
      Rails.logger.info(delivery.inspect)
    rescue => exception
      Rails.logger.error(exception.inspect)
      #si utilisateur ne recevant plus de message, on vire son profil
      if exception.is_a?(MessageQuickly::Api::OauthException) && exception.message.eql?("(#100) No matching user found")
        user = User.find_by(token: recipient_id)
        user.destroy if user
        Rails.logger.info("MESSENGER : user configuration destroyed")
      end
    end
  end

  #send a message with a generic template to the given recipient id
  def self.send_button_template_message(key, recipient_id, options = {})
    begin
      Rails.logger.info("send_button_template_message #{key} to #{recipient_id} with #{options.inspect}")
      recipient = MessageQuickly::Messaging::Recipient.new(id: recipient_id)
      delivery = MessageQuickly::Api::Messages.create(recipient) do |message|
        message.build_attachment(:button_template) do |template|

          template.text = I18n.t(key, options)

          options[:buttons].each do |button_hash|
            button_hash = MessengerHandler.button(button_hash, options[:locale]) unless button_hash.is_a? Hash
            if button_hash
              if button_hash[:payload]
                template.build_button(:postback) do |button|
                  button.title = button_hash[:title]
                  button.payload = button_hash[:payload]
                end
              elsif button_hash[:url]
                template.build_button(:web_url) do |button|
                  button.title = button_hash[:title]
                  button.url = button_hash[:url]
                end
              end
            end
          end
        end
      end
      Rails.logger.info(delivery.inspect)
    rescue => exception
      Rails.logger.error(exception.inspect)
      #si utilisateur ne recevant plus de message, on vire son profil
      if exception.is_a?(MessageQuickly::Api::OauthException) && exception.message.eql?("(#100) No matching user found")
        user = User.find_by(token: recipient_id)
        user.destroy if user
        Rails.logger.info("MESSENGER : user configuration destroyed")
      end
    end
  end

  #send a message with a generic template to the given recipient id
  def self.send_generic_template_message(elements, recipient_id, options = {})
    begin
      Rails.logger.info("send_generic_template_message to #{recipient_id} with #{options.inspect}")
      recipient = MessageQuickly::Messaging::Recipient.new(id: recipient_id)
      delivery = MessageQuickly::Api::Messages.create(recipient) do |message|
        message.build_attachment(:generic_template) do |template|
          elements.each do |element_json|
            template.build_element do |element|
              element.title = element_json[:title]
              element.subtitle = element_json[:subtitle]
              element.image_url = element_json[:image_url]

              element_json[:buttons].each do |button_hash|
                if button_hash[:payload]
                  element.build_button(:postback) do |button|
                    button.title = button_hash[:title]
                    button.payload = button_hash[:payload]
                  end
                elsif button_hash[:url]
                  element.build_button(:web_url) do |button|
                    button.title = button_hash[:title]
                    button.url = button_hash[:url]
                  end
                end
              end
            end
          end
        end
      end
      Rails.logger.info(delivery.inspect)
    rescue => exception
      Rails.logger.error(exception.inspect)
      #si utilisateur ne recevant plus de message, on vire son profil
      if exception.is_a?(MessageQuickly::Api::OauthException) && exception.message.eql?("(#100) No matching user found")
        user = User.find_by(token: recipient_id)
        user.destroy if user
        Rails.logger.info("MESSENGER : user configuration destroyed")
      end
    end
  end

  def self.button(title_key, locale)
    {title: I18n.t(title_key, {locale: locale}), payload: title_key}
  end

  #return a quick reply hash
  def self.quick_reply(payload, params)
    Rails.logger.info("paylod #{payload}")
    if payload.is_a?(String) || payload.is_a?(Symbol)
      params[:default] = payload
      Rails.logger.info("quick reply params #{params.inspect}")
      {content_type: 'text', title: I18n.t(payload, params), payload: payload}
    else
      {content_type: 'text', title: payload[:title], payload: payload[:payload]}
    end
  end


  def self.quick_reply_location
    {content_type: 'location'}
  end

end
# base_actions.rb
# Created by Edouard Brèthes on 29/08/16,
# This code is property from L'Apptelier SARL.
class BaseActions

  #send a message to the user's medium_type
  def self.send_message(key, user, options = {})
    Rails.logger.info("SENDING #{key} to #{user.inspect} with options :#{options.inspect}")

    if user
      #recomposing the params hash with the locale
      unless options[:locale]
        options[:locale] = user.language
      end
      options[:default] = key unless options[:default]

      options[:first_name] = user.first_name unless options[:first_name]

      if options[:buttons]
        MessengerHandler.send_button_template_message(key, user.token, options)
      else
        MessengerHandler.send_text_message(key, user.token, options)
      end
    end
  end

  def self.send_generic_template(elements, user, options = {})
    Rails.logger.info("SENDING GENERIC TEMPLATE #{user.inspect} with options :#{options.inspect}")

    if user
      #recomposing the params hash with the locale
      unless options[:locale]
        options[:locale] = user.language
      end

      MessengerHandler.send_generic_template_message(elements, user.token, options)
    end

  end

  #send an image to the recipient
  def self.send_image(image_uri, user)
    if user
      MessengerHandler.send_image(image_uri, user.token)
    end
  end

  # Send a waiting bubble with (...)
  def self.send_waiting_message(user)
    if user
      MessengerHandler.send_waiting_message(user.token)
    end
  end

end
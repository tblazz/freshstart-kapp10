class MessageReceivedCallback < MessageQuickly::Callback

  def self.webhook_name
    :messages
  end

  def initialize(event, json)
    super
  end

  def run
    Rails.logger.info("message received event #{event.inspect}")

    #on ne traite que les message qui sont émis par un utilisateur physique, pas une page
    if event && event.sender && event.sender.id && !event.sender.id.eql?(ENV['FACEBOOK_PAGE_ID'])
      #creating the sender profile in database if not existing
      user = User.find_or_create_from_messenger(event.sender.id)

      Rails.logger.info("user #{user.inspect}")

      if user && event.timestamp && event.timestamp > StoriesHandler.last_timestamp(user)

        #sending a waiting message
        BaseActions.send_waiting_message(user)

        begin

          BaseActions.send_message(:default, user, {locale: user.language})

        rescue Exception => exception
          Rails.logger.error(exception.inspect)
          BaseActions.send_message(:problem, user, {locale: user.language})
        end

        #saving last timestamp
        StoriesHandler.set_last_timestamp(event.timestamp, user)
      end
    end
  end

end

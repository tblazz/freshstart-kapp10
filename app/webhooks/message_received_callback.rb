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

        BaseActions.send_message(:default, user, {locale: user.language})

        begin

          elements = [{
                          title: I18n.t(:kapp10_title, {locale: user.language}),
                          subtitle: I18n.t(:kapp10_subtitle, {locale: user.language}),
                          image_url: "https://kapp10-finishline.herokuapp.com/kapp10_ad.png",
                          buttons: [
                              {url: 'https://itunes.apple.com/us/app/kapp10-partage-moments-sportifs/id1006680526', title: 'Kapp10 iOS'},
                              {url: 'https://play.google.com/store/apps/details?id=com.kappsports.kapp10', title: 'Kapp10 Android'},
                              {url: 'https://www.messenger.com/t/kapptenfr', title: 'Kapp10 Messenger'}
                          ]
                      }]


          BaseActions.send_generic_template(elements, user)

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

class PostbackCallback < MessageQuickly::Callback

  def self.webhook_name
    :messaging_postbacks
  end

  def initialize(event, json)
    super
  end

  def run
    Rails.logger.info("postback received event #{event.inspect}")

    # #on ne traite que les message qui sont émis par un utilisateur physique, pas une page
    # if event && event.sender && event.sender.id && !event.sender.id.eql?(ENV['FACEBOOK_PAGE_ID']) && event.payload
    #
    #
    #   #creating the sender profile in database if not existing
    #   user = User.find_or_create_from_messenger(event.sender.id)
    #
    #   if user && event.timestamp && event.timestamp > StoriesHandler.last_timestamp(user)
    #
    #     #sending a waiting message
    #     BaseActions.send_waiting_message(user)
    #
    #     context = StoriesHandler.get_session_context(user)
    #
    #     Rails.logger.info("payload #{event.payload}")
    #
    #     #on analyse la payload
    #     if event.payload.include?(PROPERTY_DETAIL_PREFIX)
    #       #on extrait l'id du property_ad
    #       context[PROPERTY_AD_ID] = event.payload.gsub(PROPERTY_DETAIL_PREFIX+'_', '')
    #       context[STAGE] = PROPERTY_DETAIL_PREFIX
    #     elsif event.payload.include?(CONTACT_AGENCY_PREFIX)
    #       #on extrait l'id du property_ad
    #       components = event.payload.split('_')
    #       if components && !components.empty?
    #         context[AGENCY_ID] = components[1]
    #         context[PROPERTY_AD_ID] = components[2]
    #         context[STAGE] = CONTACT_AGENCY_PREFIX
    #       end
    #     elsif event.payload.eql?(PAYLOAD_INTRO)
    #       #on purge la recherche de l'utilisateur
    #       Search.destroy_all(user: user)
    #       context[STAGE] = PAYLOAD_INTRO
    #     else
    #       context[STAGE] = event.payload
    #     end
    #
    #     Rails.logger.info("context #{context.inspect}")
    #
    #     StoriesHandler.analyse_context(user, context)
    #
    #     #saving last timestamp
    #     StoriesHandler.set_last_timestamp(event.timestamp, user)
    #
    #   end
    # end


  end

end

# stories_handler.rb
# Created by Edouard Brèthes on 31/10/16,
# This code is property from L'Apptelier SARL.
class StoriesHandler

  #return le timestamp de dernière conversation avec l'utilisateur
  # @param[User] user
  def self.last_timestamp(user)
    seq = $redis.get("#{MESSENGER_TIME_PREFIX}_#{user.token}") if user
    if seq
      seq = seq.to_i
    else
      seq = 0
    end
    Rails.logger.info("seq #{seq}")
    return seq
  end

  # Enregistre le timestamp de dernière conversation avec l'utilisateur
  # @param [Date] timestamp
  # @param [User] user
  def self.set_last_timestamp(timestamp, user)
    $redis.set("#{MESSENGER_TIME_PREFIX}_#{user.token}", timestamp, ex: CONTEXT_EXPIRATION_TIME_LONG) if user
  end

  #enregistre le contexte de conversation d'un utilisateur
  # @param [User] user
  # @param [Hash] context
  def self.set_session_context(user, context)
    Rails.logger.info("context to save #{context.inspect}")
    #saving context with an expiration date
    $redis.set("#{user.token}", context.to_json, ex: CONTEXT_EXPIRATION_TIME)
  end

  #renvoi le contexte de conversation avec un utilisateur
  # @param [User] user
  def self.get_session_context(user)
    context = $redis.get("#{user.token}") if user
    if context
      context = JSON.parse(context)
    else
      context = {}
    end
    return context
  end

  #Supprime un élément du contexte
  # @param [Hash] context
  # @param [String] key
  def self.delete_key(context, key)
    context.delete key if context.include? key
    return context
  end


end
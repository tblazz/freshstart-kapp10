class User < ActiveRecord::Base

  has_many :searches, inverse_of: :user, dependent: :destroy

  # Créé un utilisateur sur la bdd à partir du token d'un utilisateur Facebook
  # @return [User] l'utilisateur sur le bot
  # @param [String] messenger_token le token de l'utilisateur Facebook
  def self.find_or_create_from_messenger(messenger_token)

    #checking if user exists already. If not, polling FB graph API for its language
    new_record = User.exists?(token: messenger_token)
    user = User.find_or_initialize_by(token: messenger_token)

    #setting user locale
    unless new_record
      json = MessageQuickly::Api::Base.client.get(messenger_token, {fields: FACEBOOK_USER_FIELDS})
      Rails.logger.info("json #{json.inspect}")
      user.language = DEFAULT_FACEBOOK_LOCALE
      user.first_name = json['first_name'] if json.include?('first_name')
      user.last_name = json['last_name'] if json.include?('last_name')
    end
    user.save

    return user

  end

end
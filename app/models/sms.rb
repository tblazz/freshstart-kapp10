class SMS
  attr_reader :name, :time, :image_path, :race_name_mail, :rank, :race_detail, :results_url, :template, :phone_number, :campaign

  PAYLOAD_FORMAT = "<DATA><MESSAGE><![CDATA[%{message}]]></MESSAGE><CAMPAIN>%{campaign}</CAMPAIN><TPOA>%{sender_name}</TPOA><SMS><MOBILEPHONE>%{phone_number}</MOBILEPHONE></SMS></DATA>"

  def initialize(name: ,time: , image_path: 'image_path', race_name_mail: , rank:, race_detail: , results_url:, template:, phone_number:, campaign:)
    @name = name
    @time = time
    @image_path = image_path
    @race_name_mail = race_name_mail
    @rank = rank
    @template = template
    @race_detail = race_detail
    @results_url = results_url
    @phone_number = phone_number
    @campaign = campaign
  end

  def message
    template % {
      name: shortable_name,
      time: time,
      url: image_path,
      race_name_mail: race_name_mail,
      rank: rank,
      race_detail: race_detail,
      results_url: results_url
    }
  end

  def send(image_path)
    @image_path = image_path
    SendSmsJob.perform_later(payload) if phone_number =~ PHONE_REGEX
  end

  private

  def shortable_name
    #on réduit le nom à 40 caractère max. si besoin
    return name[0, SMS_MAX_NAME_LENGHT] + '.' if name.size > SMS_MAX_NAME_LENGHT
    name
  end

  def payload
    PAYLOAD_FORMAT % {
      message: message,
      campaign: campaign,
      sender_name: SENDER_SMS,
      phone_number: phone_number
    }
  end
end
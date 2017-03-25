class SendResultJob < ActiveJob::Base
  queue_as :normal

  def perform(result)
    @result = Result.find(result)
    @diploma = GenerateDiploma.new(@result).image_kit(IMAGE_HEIGHT,IMAGE_WIDTH)
    image = SaveImageToS3.new(@result.race.name, @result.race.date, @result.bib, @diploma.to_img(:jpg)).call
    short_image_path = Bitly.client.shorten(image[:image_path], history: 1).jmp_url
    p short_image_path
    # SMS
    first_names = @result.name.strip.split(/\s+/)
    first_name = first_names[0] if first_names.count > 0
    sms_message_template = @result.race.sms_message
    sms_template = sms_message_template.nil? || sms_message_template.eql?("") ? I18n.t('sms_message_template') : sms_message_template
    Rails.logger.info("sms template #{sms_template}")
    ResultMailer.mail_result(
      first_name ? first_name : @result.name,
      @result.time,
      @result.race.email_sender,
      @result.race.name,
      @result.race.email_name,
      @result.race.hashtag,
      @result.mail,
      @result.rank_total,
      @result.race.results_url,
      sms_template,
      image[:image_file_name],
      image[:image_path],
      short_image_path).deliver_later if @result.mail =~ MAIL_REGEX

     #on envoi un sms et un message Facebook si le numéro de téléphone est valide
    if @result.phone =~ PHONE_REGEX
      SendSmsJob.perform_later(first_name ? first_name : @result.name,
        @result.time,
        @result.race.email_name,
        @result.phone,
        @result.rank_total,
        @result.race.results_url,
        sms_template,
        short_image_path,
        image[:folder_name])
      # SendMessengerMessageJob.perform_later(first_name ? first_name : @name, @time, race_name_mail, phone_number, image_path)
    end
  end
end
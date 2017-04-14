class SendResultJob < ActiveJob::Base
  queue_as :normal

  def perform(result)
    @result = Result.find(result)
    @diploma = GenerateDiploma.new(@result).image_kit(IMAGE_HEIGHT,IMAGE_WIDTH)
    image = SaveImageToS3.new(@result.race.name, @result.race.date, @result.bib, @diploma.to_img(:jpg)).call
    short_image_path = Bitly.client.shorten(image[:image_path], history: 1).jmp_url

    # Envoi du mail
    ResultMailer.mail_result(
      @result.first_name,
      @result.time,
      @result.race.email_sender,
      @result.race.name,
      @result.race.email_name,
      @result.race.hashtag,
      @result.mail,
      @result.rank_total,
      @result.race.results_url,
      @result.race.sms_message,
      image[:image_file_name],
      image[:image_path],
      short_image_path).deliver_later if @result.mail =~ MAIL_REGEX

    # Envoi du SMS
    @result.sms.send(short_image_path)
  end
end
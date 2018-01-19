require 'hive_url_shortner'

class GenerateDiplomaJob < ActiveJob::Base
  queue_as :normal

  def perform(result_id)
    result = Result.find(result_id)
    diploma = GenerateDiploma.new(result).image_kit(IMAGE_HEIGHT[result.edition.template],IMAGE_WIDTH[result.edition.template])
    image = SaveImageToS3.new(result.edition.event.name, result.edition.date, result.bib, diploma.to_img(:jpg)).call
    # Rails.logger.debug image[:image_path]
    # Google::UrlShortener::Base.api_key = ENV['GOOGLE_API_KEY']
    # diploma_url =  Google::UrlShortener.shorten!(image[:image_path])
    diploma_url = HiveUrlShortner.new.shorten(image[:image_path])
    # diploma_url = Bitly.client.shorten(image[:image_path], history: 1).jmp_url
    result.update({
      diploma_generated_at: Time.now,
      diploma_url: diploma_url
    }) if diploma_url && image
  end
end

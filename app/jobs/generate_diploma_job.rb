class GenerateDiplomaJob < ActiveJob::Base
  queue_as :normal

  def perform(result_id)
    result = Result.find(result_id)
    diploma = GenerateDiploma.new(result).image_kit(IMAGE_HEIGHT,IMAGE_WIDTH)
    image = SaveImageToS3.new(result.race.name, result.race.date, result.bib, diploma.to_img(:jpg)).call
    diploma_url = Bitly.client.shorten(image[:image_path], history: 1).jmp_url
    result.update({
      diploma_generated_at: Time.now,
      diploma_url: diploma_url
    }) if diploma_url && image
  end
end
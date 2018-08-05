class DetectBibJob < ActiveJob::Base
  queue_as :normal

  def perform(photo_id)
    return unless text.present?

    photo = Photo.find(photo_id)
    results = photo.edition.results
    words = text.words
    bib = words.find { |w| w.text.in? results.pluck(:bibs) }
    return unless bib.present?

    result = result.find_by(bib: bib)
    photo.race = result.race
    photo.bib = bib
    photo.save!
  end

  private

  def text
    vision = Google::Cloud::Vision.new
    image = vision.image photo.image.url
    annotation = vision.annotate image, text: true
    annotation.text
  end
end

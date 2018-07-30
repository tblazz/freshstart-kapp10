class DetectBibJob < ActiveJob::Base
  queue_as :normal

  def perform(photo_id)
    photo = Photo.find(photo_id)
    bibs = photo.edition.results.pluck :bib
    vision = Google::Cloud::Vision.new
    image = vision.image photo.image.url
    annotation = vision.annotate image, text: true
    text = annotation.text
    return unless text.present?

    words = text.words
    bib = words.find { |w| w.text.in? bibs }
    return unless bib.present?

    photo.bib = bib
    photo.save!
  end
end

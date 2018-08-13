class DetectBibJob < ActiveJob::Base
  queue_as :normal

  def perform(photo_id)
    photo = Photo.find(photo_id)

    vision = ::Google::Cloud::Vision.new
    image = vision.image photo.image.url
    annotation = vision.annotate image, text: true

    return unless annotation.text.present?

    results = photo.edition.results
    words = text.words
    bib = words.find { |w| w.text.in? results.pluck(:bib) }

    return unless bib.present?

    result = result.find_by(bib: bib)
    photo.race = result.race
    photo.bib = bib
    photo.save!
  end
end

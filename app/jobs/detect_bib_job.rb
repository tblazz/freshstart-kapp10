class DetectBibJob < ActiveJob::Base
  queue_as :normal

  def perform(photo_id)
    photo = Photo.find(photo_id)

    vision = ::Google::Cloud::Vision.new project: "kapp10-freshstart-ocr", keyfile: JSON.parse(ENV["GOOGLE_CLOUD_KEYFILE_JSON"])
    image = vision.image photo.image.url
    annotation = vision.annotate image, text: true

    return unless annotation.text.present?
    text = annotation.text
    results = photo.edition.results
    words = text.words
    matching_word = words.find { |w| w.text.in? results.pluck(:bib) }

    return unless matching_word.present?

    bib = matching_word.text
    result = results.find_by(bib: bib)
    photo.race = result.race
    photo.bib = bib
    photo.save!
  end
end

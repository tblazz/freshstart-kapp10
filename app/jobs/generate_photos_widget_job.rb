require 'htmlentities'
require 'htmlcompressor'

class GeneratePhotosWidgetJob < ActiveJob::Base
  queue_as :normal

  def perform(edition_id)
    @edition    = Edition.find(edition_id)
    @categories = @edition.results.pluck(:categ).uniq.sort
    results     = @edition.results
    photos      = @edition.photos.map do |photo|
      result = results.select{ |r| r.bib === photo.bib }.first
      
      if result
        if result.name
          name = result.name
        else
          name = "#{result.first_name} #{result.last_name}"
        end
      else
        name = ''
      end

      {
        url:   photo.image.url,
        bib:   photo.bib,
        race:  result ? result.race_detail.parameterize : '',
        sex:   result ? result.sex.parameterize : '',
        categ: result ? result.categ.parameterize : '',
        name:  name,
      }
    end

    @photos_json  = photos.to_json
    @generated_at = Time.now

    erb_file = "#{Rails.root}/app/views/editions/photos_widget.html.erb"
    erb_str  = File.read(erb_file)
    renderer = ERB.new(erb_str)

    if renderer
      html       = renderer.result(binding)
      compressor = HtmlCompressor::Compressor.new
      KAPP10_WIDGETS_BUCKET.object(@edition.photos_widget_storage_name).put(content_type: 'text/html', body: compressor.compress(html), acl:'public-read')
      @edition.update_attribute(:photos_widget_generated_at, @generated_at)
    end
  end
end

require 'htmlentities'
require 'htmlcompressor'

class GeneratePhotosWidgetJob < ActiveJob::Base
  queue_as :normal

  def perform(race_id)
    @race = Race.find(race_id)
		p @race.photos_widget_storage_name
    @generated_at = Time.now
    erb_file = "#{Rails.root}/app/views/races/photos_widget.html.erb"
		erb_str = File.read(erb_file)
    renderer = ERB.new(erb_str)
    if renderer
      html = renderer.result(binding)
      compressor = HtmlCompressor::Compressor.new
      KAPP10_WIDGETS_BUCKET.object(@race.photos_widget_storage_name).put(content_type: 'text/html', body: compressor.compress(html), acl:'public-read')
      @race.update_attribute(:photos_widget_generated_at, @generated_at)
    end
  end
end

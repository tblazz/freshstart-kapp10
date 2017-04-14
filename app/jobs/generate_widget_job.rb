require 'htmlentities'
require 'htmlcompressor'

class GenerateWidgetJob < ActiveJob::Base
  queue_as :normal

  def perform(race_id)
    @race = Race.find(race_id)
    @generated_at = Time.now
    erb_file = "#{Rails.root}/app/views/races/widget.html.erb"
    erb_str = File.read(erb_file)
    renderer = ERB.new(erb_str)
    if renderer
      html = renderer.result(binding)
      compressor = HtmlCompressor::Compressor.new
      KAPP10_WIDGETS_BUCKET.object(@race.widget_storage_name).put(content_type: 'text/html', body: compressor.compress(html), acl:'public-read')
      @race.update_attribute(:widget_generated_at, @generated_at)
    end
  end
end
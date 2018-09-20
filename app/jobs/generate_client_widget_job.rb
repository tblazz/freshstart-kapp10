require 'htmlentities'
require 'htmlcompressor'

class GenerateClientWidgetJob < ActiveJob::Base
  queue_as :normal

  def perform(client_id)
    @client = Client.find(client_id)
    @events = Event.includes(:editions, :races).where.not(editions: { id: nil }).with_client(@client.id).sort { |a,b| a.editions.last.date <=> b.editions.last.date }.reverse

    @event_array = []
    @event_lines = []
    @events.each do |event|
      @event_array << {'name' => event.name, 'department' => event.department, 'type' => event.races.map { |r| r.race_type.capitalize }.uniq.join(' '), 'widget_url' => event.editions.last.widget_url}
      @event_lines << generate_event_line(event)
    end

    @types = ['Route', 'Trail']
    @departments = @events.map(&:department).uniq.reject(&:blank?)

    erb_file = "#{Rails.root}/app/views/clients/widget.html.erb"
    erb_str = File.read(erb_file)
    renderer = ERB.new(erb_str)
    if renderer
      html = renderer.result(binding)
      compressor = HtmlCompressor::Compressor.new
      KAPP10_WIDGETS_BUCKET.object(@client.widget_storage_name).put(content_type: 'text/html', body: compressor.compress(html), acl:'public-read')
      @client.update_attribute(:results_widget, @client.widget_gist)
    end
  end

  def generate_event_line(event)
    edition = event.editions.last

    line = "<div class='event col-xs-12' data-name-search='#{ event.name }' data-department-search='#{ event.department }' data-type-search='#{event.races.map(&:race_type).reject(&:blank?).join(' ')}' data-month-search='#{get_month(edition.date)}'>"
      line += "<div class='pull-left'>"
        line += "<h3>#{ event.name }</h3>"
        line += "<ul class='list-inline'>"
          line += "<li><div class='logo-edition'><img src='#{Edition::S3_BASE_URL}/images/icoTrailModalite.png'>#{ event.races.map(&:race_type).reject(&:blank?).join(', ') }</div></li>"
          line += "<li><div class='logo-edition'><img src='#{Edition::S3_BASE_URL}/icoLocality.png'>#{ event.department }</div></li>"
          line += "<li><div class='logo-edition'><img src='#{Edition::S3_BASE_URL}/icoDistance.png'>#{ event.races.map(&:name).uniq.join(', ') }</div></li>"
        line += "</ul>"
      line += "</div>"
      line += "<div class='pull-right'>"
        line += "<div>"
          line += "<ul class='list-inline'>"
            line += "<li>"
              line += "<div>#{ edition.date.strftime('%d/%m/%Y') }</div>"
            line += "</li>"
            line += "<li>"
              line += "<div>#{ "#{edition.results.count} <span>finisseurs</span>" if edition.results.any? }</div>"
            line += "</li>"
            line += "<li>"
              line += "<div><a class='btn btn-warning btn-results' onclick=\"displayResultsPage('#{ edition.widget_url }')\">Voir les résultats</a></div>"
            line += "</li>"
          line += "</ul>"
        line += "</div>"
      line += "</div>"
    line += "</div>"

    line
  end

  def get_month(date)
    case date.month
    when 1 then 'janvier'
    when 2 then 'fevrier'
    when 3 then 'mars'
    when 4 then 'avril'
    when 5 then 'mai'
    when 6 then 'juin'
    when 7 then 'juillet'
    when 8 then 'aout'
    when 9 then 'septembre'
    when 10 then 'octobre'
    when 11 then 'novembre'
    when 12 then 'decembre'
    end
  end
end

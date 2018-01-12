require 'htmlentities'
require 'htmlcompressor'

class GenerateClientWidgetJob < ActiveJob::Base
  queue_as :normal

  def perform(client_id)
    @client = Client.find(client_id)
    @events = Event.with_client(@client.id)

    @event_array = []
    @event_lines = []
    @events.each do |event|
      @event_array << {'name' => event.name, 'department' => event.department, 'type' => 'Route', 'widget_url' => event.editions.last.widget_url}
      @event_lines << generate_event_line(event)
    end

    @types = ['Route']
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
    line = "<div class='event' data-name-search='#{ event.name }' data-department-search='#{ event.department }' data-type-search='#{event.races.map(&:race_type).reject(&:blank?).join(' ')}' data-month-search='#{get_month(event.editions.last.date)}'>"

      line += "<div class='row'>"
        line += "<div class='col-md-6'><h3>#{ event.name }</h3></div>"
        line += "<div class='col-md-6'><div class='pull-right'><h4>#{ event.editions.last.date.strftime('%d-%m-%Y') }</h4></div></div>"
      line += "</div>"

      line += "<div class='row'>"
        line += "<div class='col-md-6'>"
          line += "<div><img src='https://evenementwidget.herokuapp.com/assets/images/lieu.png'>#{ event.department }</div>"
          line += "<div><img src='https://evenementwidget.herokuapp.com/assets/images/distance.png'>#{ event.races.map(&:name).uniq.join(', ') }</div>"
          line += "<div><img src='https://evenementwidget.herokuapp.com/assets/images/type.png'>#{ event.races.map(&:race_type).reject(&:blank?).join(', ') }</div>"
        line += "</div>"

        line += "<div class='col-md-6'>"
          line += "<div class='row'><div class='pull-right'><div>#{ "#{event.editions.last.results.count} particpants" if event.editions.last.results.count > 0 }</div></div></div>"
          line += "<div class='row'><div class='pull-right'><a class='btn btn-warning' onclick=\"displayResultsPage('#{ event.editions.last.widget_url }')\">Voir les résultats</a></div></div>"
        line += "</div>"
      line += "</div>"

    line += "</div>"
    line
  end

  def get_month(date)
    month = date.month
    case month
      when 1
        'janvier'
      when 2
        'fevrier'
      when 3
        'mars'
      when 4
        'avril'
      when 5
        'mai'
      when 6
        'juin'
      when 7
        'juillet'
      when 8
        'aout'
      when 9
        'septembre'
      when 10
        'octobre'
      when 11
        'novembre'
      when '12'
        'decembre'
    end
  end
end
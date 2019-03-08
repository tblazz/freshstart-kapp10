class API::V2::EditionsController < API::V2::ApplicationController
  def index
    query_params = params["query_params"] || {}
    limit        = query_params['limit'] || 3

    if query_params['with_lastest_results_races_data']
      editions_and_results = Edition.with_lastest_results(limit)

      editions = editions_and_results[:editions]
      results  = editions_and_results[:results]
      
      races = results.map do |result|
        Race.find(result.race_id)
      end

      events = editions.map do |edition|
        Event.find(edition.event_id)
      end

      render json: { editions: editions, races: races, events: events }

    elsif query_params['with_next_races_data']
      editions = Edition.next(limit)

      editions = editions
      
      races = editions.map do |edition|
        edition.races.first
      end

      events = editions.map do |edition|
        Event.find(edition.event_id)
      end

      render json: { editions: editions, races: races, events: events }

    else
      @editions = Edition.order(:date)
  
      if query_params.present?
        begin_date = query_params[:begin_date]
        end_date   = query_params[:end_date]
        name       = query_params[:name]  || ""
        place      = query_params[:place] || ""
        types      = query_params[:types] || []
        
        if begin_date && begin_date != ''
          @editions = @editions.where("DATE(editions.date) >= ? AND DATE(editions.date) <= ?", begin_date, end_date).order(:date)
        end
        
        if name.present?
          @editions = @editions.joins(:event).where("LOWER(events.name) LIKE ?", "%#{name.downcase}%").order(:date)
        end

        if place.present?
          @editions = @editions.joins(:event).where("LOWER(events.place) LIKE ?", "%#{place.downcase}%").order(:date)
        end

        if types.any?
          @editions = @editions.joins(:races).where(races: {race_type: types }).order(:date)
        end
      end

      raw_editions = @editions.map do |edition|
        edition_hash(edition)
      end
  
      render json: raw_editions
    end
  end

  def show
    edition_id   = params[:id]
    edition      = Edition.find(edition_id)

    query_params  = params["query_params"]||{}
    if query_params["race_id"]
      race_id = query_params["race_id"]
    else
      race_id = edition.races.order(name: :asc).first.id
    end
    race = Race.find(race_id)

    edition_modes = ['description', 'results', 'photos']
    if query_params["edition_mode"] && edition_modes.include?(query_params["edition_mode"])
      edition_mode  = query_params["edition_mode"]
    else
      edition_mode  = edition_modes.first
    end

    if edition_mode == 'description'
      
    elsif edition_mode == 'results'
      race_results = race.results.order(rank: :asc)||[]
      categories   = race_results.pluck(:categ).uniq.map{|categ| categ.upcase}.sort
      sexes        = race_results.map{|res| res.runner.sex.upcase}.uniq.sort
      race_results = race_results.map do |res|
        {
          runner_id:  res.runner.id,
          rank:       res.rank,
          first_name: res.runner.first_name,
          last_name:  res.runner.last_name,
          sex:        res.runner.sex.upcase,
          categ:      res.categ.upcase,
          speed:      res.speed,
          time:       res.time,
        }
      end

      results = {
        categories: categories,
        sexes:      sexes,
        data:       race_results,
      }
    elsif edition_mode == 'photos'
      results_with_photos = race.results.select{|result| result.photo.class == Photo}
      photos              = results_with_photos.map do |result|
        photo = result.photo
        {
          url:       ENV['RAILS_ENV'] == 'development' ? photo.direct_image_url : photo.image.url,
          race_name: result.race.name,
        }
      end
    end

    races = edition.races.order(name: :asc).map do |race|
      if race.id == race_id
        race_results = results
        race_photos  = photos
      end
      {
        id:                  race.id,
        name:                race.name,
        race_type:           race.race_type,
        participants_number: race.results.count,
        results:             race_results,
        photos:              race_photos,
      }
    end

    response = {
      name:    edition.description,
      place:   edition.event.place,
      date:    edition.date,
      website: edition.event.website,
      phone:   edition.event.phone,
      races:   races,
    }

    render json: response
  end

  def calendar
    query_params    = params['query_params'] || {}
    current_date    = Date.parse(query_params['start_date']) || Time.now

    month_beginning = Date.new(current_date.year, current_date.month, 1)
    start_date      = month_beginning - 7.days
    end_date        = Date.new(current_date.year, current_date.month, 1) + 1.month + 7.days

    month_editions  = Edition.where('date >= ? AND date <= ?', start_date, end_date)
    response        = month_editions.map do |edition|
      {
        id:   edition.id,
        name: edition.description,
        date: edition.date,
      }
    end

    render json: response
  end

  def search_list
    query_params = params['query_params']||{}
    search_query = query_params['search_query']||""

    response     = Edition.where('description ILIKE ?', "#{search_query}%").order(description: :asc).limit(10)
    response     = response.map do |edition|
      {
        id:   edition.id,
        name: edition.description,
      }
    end

    render json: response
  end

  private

  def edition_hash(edition)
    event = edition.event

    {
      id:                              edition.id,
      date:                            edition.date,
      name:                            event.name,
      place:                           event.place,
      description:                     edition.description,
      event_id:                        edition.event_id,
      email_sender:                    edition.email_sender,
      email_name:                      edition.email_name,
      hashtag:                         edition.hashtag,
      results_url:                     edition.results_url,
      external_link:                   edition.external_link,
      created_at:                      edition.created_at,
      updated_at:                      edition.updated_at,
      background_image_file_name:      edition.background_image_file_name,
      races:                           edition.races,
      number_of_participants:          edition.runners_count#,
      # sms_message:                     edition.sms_message,
      # template:                        edition.template,
      # widget_generated_at:             edition.widget_generated_at,
      # photos_widget_generated_at:      edition.photos_widget_generated_at,
      # external_link_button:            edition.external_link_button,
      # raw_results_file_name:           edition.raw_results_file_name,
      # raw_results_content_type:        edition.raw_results_content_type,
      # raw_results_file_size:           edition.raw_results_file_size,
      # raw_results_updated_at:          edition.raw_results_updated_at,
      # background_image_content_type:   edition.background_image_content_type,
      # background_image_file_size:      edition.background_image_file_size,
      # background_image_updated_at:     edition.background_image_updated_at,
      # sendable_at_home:                edition.sendable_at_home,
      # sendable_at_home_price_cents:    edition.sendable_at_home_price_cents,
      # download_chargeable:             edition.download_chargeable,
      # download_chargeable_price_cents: edition.download_chargeable_price_cents,
    }
  end
end

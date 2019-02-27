class API::V2::EditionsController < API::V2::ApplicationController
  def index
    query_params = params["query_params"] || {}
    number_of_elements_by_page = query_params['number_of_elements_by_page'] || 24
    limit                      = query_params['number_of_elements_by_page'] || 3
    page_number                = query_params['page_number'] || 1
    offset                     = (page_number - 1) * number_of_elements_by_page

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
      editions = Edition.order(created_at: :desc).offset(offset).limit(number_of_elements_by_page)
      render json: editions
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
      race_results = race.results||[]
      results      = race_results.map do |res|
        {
          rank:       res.rank,
          first_name: res.runner.first_name,
          last_name:  res.runner.last_name,
          sex:        res.runner.sex,
          categ:      res.categ,
          speed:      res.speed,
          time:       res.time,
        }
      end
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
      id:      edition.id,
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
end

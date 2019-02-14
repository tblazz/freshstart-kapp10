class API::V2::EditionsController < API::V2::ApplicationController
  def index
    query_params = params["query_params"] || {}
    number_of_elements_by_page = query_params['number_of_elements_by_page'] || 24
    limit                      = query_params['number_of_elements_by_page'] || 3
    page_number                = query_params['page_number'] || 1
    offset                     = (page_number - 1) * number_of_elements_by_page

    if query_params['with_lastest_results_races_data']
      editions_and_results = Edition.with_lastest_results(limit)

      @editions = editions_and_results[:editions]
      results  = editions_and_results[:results]
      
      @races = results.map do |result|
        Race.find(result.race_id)
      end

      @events = @editions.map do |edition|
        Event.find(edition.event_id)
      end

      render json: { editions: @editions, races: @races, events: @events }

    elsif query_params['with_next_races_data']
      editions = Edition.next(limit)

      @editions = editions
      
      @races = @editions.map do |edition|
        edition.races.first
      end

      @events = @editions.map do |edition|
        Event.find(edition.event_id)
      end

      render json: { editions: @editions, races: @races, events: @events }
    else
      @editions = Edition.order(created_at: :desc).offset(offset).limit(number_of_elements_by_page)
      render json: @editions
    end
  end
end

class API::V2::RunnersController < API::V2::ApplicationController
  before_action :set_runner, only: [:show]

  def index
    query_params               = params["query_params"]||{}
    number_of_elements_by_page = query_params["number_of_elements_by_page"]||16
    page_number                = query_params["page_number"]||1
    offset                     = (page_number - 1) * number_of_elements_by_page
    search_inputs              = query_params["search_inputs"]||{}
    runner_name_input          = search_inputs["runner_name_input"]
    category_input             = search_inputs["category_input"]
    sex_input                  = search_inputs["sex_input"]

    sql_params = []
    sql_query  = []

    if runner_name_input.present?
      sql_query << <<~SQL
        first_name ILIKE ? OR last_name ILIKE ?
      SQL

      sql_params += ["%#{runner_name_input}%", "%#{runner_name_input}%"]
    end

    runners_for_page = Runner.select("id, first_name, last_name, category, sex, department").
                              where(sql_query.join(' AND '), *sql_params)

    runners_for_page = runners_for_page.real.
                              offset(offset).
                              limit(number_of_elements_by_page).
                              order(last_name: :asc, first_name: :asc)

    number_of_runners = Runner.where(sql_query.join(' AND '), *sql_params).real.count

    theorical_number_of_pages = (number_of_runners.to_f / number_of_elements_by_page).ceil
    number_of_pages           = theorical_number_of_pages.zero? ? 1 : theorical_number_of_pages

    response = {
      number_of_pages: number_of_pages,
      runners:         runners_for_page,
      sexes:           ['M', 'F']
    }

    render json: response
  end

  def show
    query_params = params["query_params"]||{}
    results_mode = query_params["results_mode"]||"last"

    response = {
      runner_data:  get_runner_data,
      runner_stats: get_stats,
    }

    if results_mode == "results"
      response[:runner_results] = get_results
    elsif results_mode == "photos"
      response[:runner_photos]  = get_photos
    end

    render json: response
  end

  def search_list
    query_params = params['query_params']||{}
    search_query = query_params['search_query']||""

    response     = Runner.real.where('last_name ILIKE ?', "%#{search_query}%").order(last_name: :asc).limit(10)
    response     = response.map do |runner|
      {
        id:         runner.id,
        first_name: runner.first_name,
        last_name:  runner.last_name,
      }
    end

    render json: response
  end

  private

  def set_runner
    @runner = Runner.find(params[:id])
  end

  def get_runner_data
    {
      id:         @runner.id,
      first_name: @runner.first_name,
      last_name:  @runner.last_name,
      department: @runner.department,
      sex:        @runner.sex,
      category:   @runner.category,
    }
  end

  def get_stats
    results = @runner.results

    if results.empty?
      stats = {
        best_rank:               nil,
        favorite_event_name:     nil,
        races_number:            nil,
        this_month_races_number: nil,
      }
    else
      stats = {
        best_rank:               results.order(rank: :asc).first.rank,
        favorite_event_name:     get_favorite_event_name,
        races_number:            results.count,
        this_month_races_number: get_this_month_races_number,
      }
    end

    stats
  end

  def get_photos
    results = @runner.results
    results_with_photos = results.select{|result| result.photo.class == Photo}

    results_with_photos.map do |result|
      photo = result.photo
      {
        url:       Rails.env == 'development' ? photo.direct_image_url : photo.image.url,
        race: {
          id:   result.race.id,
          name: result.race.name,
        },
        edition: {
          id:          result.race.edition.id,
          description: result.race.edition.description,
        },
        event: {
          name: result.race.edition.event.name,
        },
      }
    end
  end

  def get_results
    runner_results = @runner.results.sort_by{|result| result.edition.date}.reverse
    runner_results.map do |r|
      {
        event_name:          r.race.edition.event.name,
        edition_id:          r.race.edition.id,
        race_id:             r.race.id,
        race_name:           r.race.name,
        race_date:           r.race.date,
        race_start_at:       r.race.start_at,
        rank:                r.rank,
        participants_number: r.race.results.count,
        speed:               r.speed,
        time:                r.time,
        categ:               r.categ,
      }
    end
  end

  def get_favorite_event_name
    results         = @runner.results
    cleaned_results = results.select {|result| result.edition}
    events          = cleaned_results.map{|result| result.edition.event}
    favorite_event  = occurrence_max(events)
    favorite_event.name
  end

  def get_this_month_races_number
    current_year_month   = Time.now.strftime("%Y%m")
    results_dates        = @runner.results.map {|result| result.edition.date}
    results_dates.select{|date| current_year_month == date.strftime("%Y%m")}.count
  end

  def occurrences_number(array)
    array.inject(Hash.new(0)) { |h,v| h[v] += 1; h }
  end

  def occurrence_max(array)
    freq = occurrences_number(array)
    array.max_by { |v| freq[v] }
  end
end

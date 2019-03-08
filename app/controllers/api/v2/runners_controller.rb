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

    
    categories = Runner.where.not(category: nil).order(category: :asc).pluck(:category).uniq
    sexes      = Runner.where.not(sex: nil).order(sex: :asc).pluck(:sex).uniq
    runners    = Runner.order(last_name: :asc, first_name: :asc)
    
    if runner_name_input
      runners = runners.where("first_name ILIKE ? OR last_name ILIKE ?", "%#{runner_name_input}%", "%#{runner_name_input}%")
    end
    
    if sex_input && sex_input != ""
      runners = runners.where(sex: sex_input)
    end
    
    if category_input && category_input != ""
      runners = runners.where(category: category_input)
    end

    theorical_number_of_pages = (runners.count.to_f / number_of_elements_by_page).ceil
    number_of_pages           = theorical_number_of_pages.zero? ? 1 : theorical_number_of_pages
    runners_for_page          = runners.offset(offset).limit(number_of_elements_by_page)
    runners_data_for_page     = runners_for_page.map do |runner|
      {
        id:         runner.id,
        first_name: runner.first_name,
        last_name:  runner.last_name,
        category:   runner.category,
        sex:        runner.sex,
        department: runner.department,
      }
    end
    
    response = {
      number_of_pages: number_of_pages,
      runners:         runners_data_for_page,
      categories:      categories,
      sexes:           sexes,
    }

    render json: response
  end

  def show
    query_params = params["query_params"]||{}
    results_mode = query_params["results_mode"]||"last"

    response = {
      runner_data:         get_runner_data,
      runner_stats:        get_stats,
    }

    if results_mode == "last_results"
      response[:runner_last_results] = get_last_results(3)
    elsif results_mode == "all_results"
      response[:runner_all_results]  = get_all_results
    elsif results_mode == "photos"
      response[:runner_photos]       = get_photos
    end

    render json: response
  end

  def search_list
    query_params = params['query_params']||{}
    search_query = query_params['search_query']||""

    response     = Runner.where('last_name ILIKE ?', "#{search_query}%").order(last_name: :asc).limit(10)
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
        url:       ENV['RAILS_ENV'] == 'development' ? photo.direct_image_url : photo.image.url,
        race_name: result.race.name,
      }
    end
  end

  def get_all_results
    @runner.results.map do |r|
      {
        race_name:           r.race.name,
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
  
  def get_last_results(number_of_results)
    sorted_results = @runner.results.sort_by{|result| result.edition.date}.reverse
    last_results   = sorted_results.first(number_of_results)

    last_results.map do |r|
      {
        race_name:           r.race.name,
        rank:                r.rank,
        participants_number: r.race.results.count,
        speed:               r.speed,
        time:                r.time,
      }
    end
  end

  def occurrences_number(array)
    array.inject(Hash.new(0)) { |h,v| h[v] += 1; h }
  end

  def occurrence_max(array)
    freq = occurrences_number(array)
    array.max_by { |v| freq[v] }
  end
end
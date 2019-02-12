class API::V2::EditionsController < API::V2::ApplicationController
  def index
    query_params = params["query_params"] || {}
    number_of_elements_by_page = query_params['number_of_elements_by_page'] || 24
    limit                      = query_params['number_of_elements_by_page'] || 3
    page_number                = query_params['page_number'] || 1
    offset                     = (page_number - 1) * number_of_elements_by_page

    if query_params['with_lastest_results']
      editions_and_results = Edition.with_lastest_results(limit)

      @editions = editions_and_results[:editions]
      @results  = editions_and_results[:results]

      render json: { editions: @editions, results: @results }
    else
      @editions = Edition.order(created_at: :desc).offset(offset).limit(number_of_elements_by_page)
      render json: @editions
    end
  end
end

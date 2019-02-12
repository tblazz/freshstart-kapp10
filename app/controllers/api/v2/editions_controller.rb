class API::V2::EditionsController < API::V2::ApplicationController
  def index
    query_params = params["query_params"] || {}
    number_of_elements_by_page = query_params['number_of_elements_by_page'] || 24
    limit                      = query_params['number_of_elements_by_page'] || 3
    page_number                = query_params['page_number'] || 1
    offset                     = (page_number - 1) * number_of_elements_by_page

    if query_params['with_lastest_results']
      @editions = Edition.with_lastest_results(limit)
    else
      @editions = Edition.order(created_at: :desc).offset(offset).limit(number_of_elements_by_page)
    end

    render json: @editions
  end
end

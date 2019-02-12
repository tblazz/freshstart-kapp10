class API::V2::RunnersController < API::V2::ApplicationController
  def index
    query_params               = params["query_params"] || {}
    number_of_elements_by_page = query_params["number_of_elements_by_page"] || 24
    page_number                = query_params["page_number"] || 1
    offset                     = (page_number - 1) * number_of_elements_by_page

    @runners = Runner.order(created_at: :desc).offset(offset).limit(number_of_elements_by_page)
    render json: @runners
  end
end
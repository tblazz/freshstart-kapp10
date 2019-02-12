class API::V2::EditionsController < API::V2::ApplicationController
  def index
    if params[:with_lastest_results].true?
      @editions = Edition.with_lastest_results(params[:limit] || 3)
    else
      @editions = Edition.order(created_at: :desc)
    end

    render json: @editions
  end
end

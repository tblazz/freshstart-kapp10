class API::V2::EditionsController < API::V1::ApplicationController
  def index
    if params[:with_results].true?
      @editions = Edition.with_results
    end

    render json: @editions
  end
end

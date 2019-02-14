class API::V2::FeaturedRunnersController < API::V2::ApplicationController
  def index
    @runners = Runner.order(created_at: :desc).limit(4)
    render json: @runners
  end
end

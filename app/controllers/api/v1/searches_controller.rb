class API::V1::SearchesController < API::V1::ApplicationController
  def show
    event_name = params["search-input"]
    @events = Event.where("name ILIKE ?", "%#{event_name}%" ).limit(8)

    render json: @events
  end
end

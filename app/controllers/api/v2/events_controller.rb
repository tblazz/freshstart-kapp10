class API::V2::EventsController < API::V2::ApplicationController
  def index
    @events = Event.all

    query_params = params[:query_params]

    if query_params.present?
      date = query_params[:event_date]
      
      if date && date != ''
        @events = Event.joins(:editions).where("DATE(editions.date) = ?", date)
      end
    end


    render json: @events.to_json
  end
end

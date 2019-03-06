class API::V2::RacesController < API::V2::ApplicationController
  def index
    query_params = params["query_params"] || {}
    
    edition = Edition.find(params[:edition_id])

    raw_races = edition.races.map do |race|
      {
        id:                              race.id,
        name:                            race.name,
        email_sender:                    race.email_sender,
        email_name:                      race.email_name,
        date:                            race.date,
        hashtag:                         race.hashtag,
        results_url:                     race.results_url,
        sms_message:                     race.sms_message,
        created_at:                      race.created_at,
        updated_at:                      race.updated_at,
        raw_results_file_name:           race.raw_results_file_name,
        raw_results_content_type:        race.raw_results_content_type,
        raw_results_file_size:           race.raw_results_file_size,
        raw_results_updated_at:          race.raw_results_updated_at,
        external_link:                   race.external_link,
        edition_id:                      race.edition_id,
        coef:                            race.coef,
        category:                        race.category,
        department:                      race.department,
        race_type:                       race.race_type
        # background_image_file_name:      race.background_image_file_name,
        # background_image_content_type:   race.background_image_content_type,
        # background_image_file_size:      race.background_image_file_size,
        # background_image_updated_at:     race.background_image_updated_at,
        # template:                        race.template,
        # widget_generated_at:             race.widget_generated_at,
        # photos_widget_generated_at:      race.photos_widget_generated_at,
        # external_link_button:            race.external_link_button,
      }
    end

    render json: raw_races
  end
end

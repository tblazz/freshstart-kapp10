task :convert_races_into_events => :environment do
  p '*** START CONVERTING RACES ***'
  races = Race.where(edition_id: nil)
  p races.count

  races.each do |race|
    p "### Race : #{race.id} ###"
    begin
      event = Event.create(name: race.name)

      edition = Edition.create(event: event, 
                               date: race.date, 
                               description: race.name,
                               email_sender: race.email_sender,
                               email_name: race.email_name,
                               hashtag: race.hashtag,
                               results_url: race.results_url,
                               sms_message: race.sms_message,
                               raw_results_file_name: race.raw_results_file_name,
                               raw_results_content_type: race.raw_results_content_type,
                               raw_results_file_size: race.raw_results_file_size,
                               raw_results_updated_at: race.raw_results_updated_at,
                               background_image_file_name: race.background_image_file_name,
                               background_image_content_type: race.background_image_content_type,
                               background_image_file_size: race.background_image_file_size,
                               background_image_updated_at: race.background_image_updated_at,
                               template: race.template,
                               widget_generated_at: race.widget_generated_at,
                               photos_widget_generated_at: race.photos_widget_generated_at,
                               external_link: race.external_link,
                               external_link_button: race.external_link_button
      )

      race.update(edition_id: edition.id)
    rescue => e
      p "## ERROR ## : #{race.id}"
      p e
      next
    end
  end
end

task :update_race_id_from_photos => :environment do
  p '*** START UPDATING RACE_ID FROM PHOTOS ***'
  photos = Photo.where(edition_id: nil)
  p photos.count

  photos.each do |photo|
    p '.'
    begin
      race = Race.find(photo.race_id)
      edition = race.edition
      
      photo.update(edition_id: edition.id)
    rescue => e
      p "## ERROR ## : #{photo.id}"
      p e
      next
    end
  end
end

task :update_race_id_from_results => :environment do
  p '*** START UPDATING RACE_ID FROM RESULTS ***'
  results = Result.where(edition_id: nil)
  p results.count

  results.each do |result|
    p result.id
    begin
      race = Race.find(result.race_id)
      edition = race.edition

      result.update(edition_id: edition.id)
    rescue => e
      p "## ERROR ## : #{result.id}"
      p e
      next
    end
  end
end

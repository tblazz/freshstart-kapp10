namespace :events do
  desc "Set events geocoding"
  task set_geocoding: :environment do
    puts "### Beginning of events geocoding ###"

    Event.where.not(place: nil).each do |event|
      
    end

    puts "### End of events geocoding ###"
  end
end
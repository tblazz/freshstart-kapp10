require 'csv'

class ResultController < ApplicationController

  protect_from_forgery with: :exception

  #définition des index pour le parsing CSV
  PHONE_INDEX = 0
  MAIL_INDEX = 1
  RANK_INDEX = 2
  NAME_INDEX = 3
  NUMBER_INDEX = 5
  TIME_INDEX = 10
  SPEED_INDEX = 11


  def new
  end

  def create
    #si on a un fichier
    if params[:file]
      #on récupère le fichier uploadé
      file = params[:file].read
      filename = params[:file].original_filename

      #on enregistre le fichier uploadé dans le répertoire public
      path = File.join Rails.root, 'public', filename
      if path
        if File.extname(path) == CSV_EXTENSION
          File.open(path, 'wb') { |f| f.write file }

          #on parcours le fichier CSV
          CSV.foreach(path, :headers => true, :col_sep => ";") do |row|
            # ProcessResultJob.perform_now(row.to_hash)
            if row


              #on génère le HTML contenant ces informations
              erb_file = "#{Rails.root}/app/views/result/result_template.html.erb"
              erb_str = File.read(erb_file)

              phone = row[PHONE_INDEX]
              mail = row[MAIL_INDEX]
              @name = row[NAME_INDEX]
              @rank = row[RANK_INDEX]
              @rank_total = row[RANK_INDEX]
              @time = row[TIME_INDEX]
              @speed = row[SPEED_INDEX]
              @number = row[NUMBER_INDEX]
              @race_name = "Ahargo Lasterkaz"
              @race_date = "Barcus 30 avril 2016"

              @rank_image = ActionController::Base.helpers.image_tag('ic_medal.png')
              @time_image = ActionController::Base.helpers.image_tag('ic_timer.png')
              @speed_image = ActionController::Base.helpers.image_tag('ic_speed.png')

              renderer = ERB.new(erb_str)
              if renderer
                rendered_html = renderer.result(binding)

                #on sauve le HTML dans une image en local
                kit = IMGKit.new(rendered_html, height: IMAGE_HEIGHT, width: IMAGE_WIDTH)
                kit.stylesheets << "#{Rails.root}/app/assets/stylesheets/result_template.css.erb"
                imagepath = File.join Rails.root, 'public', @race_name+ "-"+ @name+ ".jpg"
                File.open(imagepath, 'wb') { |f| f.write kit.to_img(:jpg) }

              end

            end
          end
          File.delete path
        else
          #todo redirect
        end
      else
        #TODO redirect
      end
    else
      #TODO redirect
    end

  end
end
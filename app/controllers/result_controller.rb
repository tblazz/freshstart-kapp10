require 'csv'
require 'charlock_holmes'

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
  MESSAGE_INDEX = 12
  RACE_DETAIL_INDEX = 13

  def get
    @name = "ABCDEFGHIJKLMNOPQRSTUVWXYZABCDEFGHIJKLMNOPQRSTUVWXYZABCDEFGHIJKLMNOPQRSTUVWXYZ"
    @message = "ABCDEFGHIJKLMNOPQRSTUVWXYZABCDEFGHIJKLMNOPQRSTUVWXYZABCDEFGHIJKLMNOPQRSTUVWXYZ"
    @rank = 43
    @rank_total = 140
    @time = "3\"10'3"
    @speed = 19
    @number = 666
    @race_name = I18n.t('race_name')
    @race_date = I18n.t('race_date')
    @race_detail = "ABCDEFGHIJKLMNOPQRSTUVWXYZABCDEFGHIJKLMNOPQRSTUVWXYZABCDEFGHIJKLMNOPQRSTUVWXYZ"

    @rank_image = root_url+'template/images/ic_medal.png'
    @time_image = root_url+'template/images/ic_timer.png'
    @speed_image = root_url+'template/images/ic_speed.png'
    render 'result/template'
  end

  def new
    @message = nil
  end

  def create
    #si on a un fichier
    if params[:file]
      if params[:race_name] && params[:race_date] && params[:sender_mail] && params[:race_name_mail]
        #on récupère le fichier uploadé
        file = params[:file].read
        filename = params[:file].original_filename

        #on enregistre le fichier uploadé dans le répertoire public
        path = File.join Rails.root, 'public', filename
        if path
          if File.extname(path) == CSV_EXTENSION
            File.open(path, 'wb') { |f| f.write file }

            #on transcode le fichier en UTF8 si besoin
            content = File.read(path)
            detection = CharlockHolmes::EncodingDetector.detect(content)
            utf8_encoded_content = CharlockHolmes::Converter.convert content, detection[:encoding], 'UTF-8'
            File.open(path, 'wb') { |f| f.write utf8_encoded_content }

            # #on parcours une premère fois le CSV pour déterminer le nombre total de concurrents
            # CSV.foreach(path, :headers => true, :col_sep => CSV_SEPARATOR) do |row|
            #   @rank_total = row[RANK_INDEX]
            # end

            #on parcours le fichier CSV
            CSV.foreach(path, :headers => true, :col_sep => CSV_SEPARATOR) do |row|
              if row

                name = row[NAME_INDEX]
                rank = row[RANK_INDEX]
                time = row[TIME_INDEX]
                speed = row[SPEED_INDEX]
                number = row[NUMBER_INDEX]
                mail = row[MAIL_INDEX]
                phone_number = row[PHONE_INDEX]
                message = row[MESSAGE_INDEX]
                race_detail = row[RACE_DETAIL_INDEX]

                #on parse le champ hashtag pour découper les hashtags présents
                complete_hash_tag = ''
                if params[:hash_tag]
                  hash_tags = params[:hash_tag].strip.split /\s+/
                  #on ajoute un # si absent du hashtag
                  hash_tags.each do |hash_tag|
                      complete_hash_tag = complete_hash_tag+"#{hash_tag.start_with?('#') ? '' : '#'}#{hash_tag} "
                    end
                end
                TreatResultJob.perform_later(name, rank, time, speed, number, mail, phone_number, params[:race_name], params[:race_date], message, race_detail, params[:sender_mail], params[:race_name_mail], complete_hash_tag, root_url)

              end
            end
            File.delete path
          else
            redirect_to root_url, alert: "Le fichier envoyé n'est pas au format CSV."
          end
        else
          redirect_to root_url, alert: "Aucun fichier envoyé. Veuillez sélectionner un fichier et cliquer sur Envoyer."
        end
      else
        redirect_to root_url, alert: "Veuillez saisir le nom et la date de la course, ainsi que les paramètres pour l'envoi d'email"
      end
    else
      redirect_to root_url, alert: "Aucun fichier envoyé. Veuillez sélectionner un fichier et cliquer sur Envoyer."
    end

  end
end
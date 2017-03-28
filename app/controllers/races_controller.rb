class RacesController < ApplicationController

  protect_from_forgery with: :exception,  except: :widget
  before_action :set_race, only: [:show, :edit, :update, :destroy, :send_results, :widget]

  def index
    @races = Race.all
  end

  def new
    @race = Race.new
  end

  def show
  end

  def widget
    render layout: false
  end

  def create
    @race = Race.new(race_params)

    respond_to do |format|
      if @race.save
        decode_results if race_params[:raw_results]
        format.html { redirect_to @race, notice: 'race was successfully created.' }
        format.json { render :show, status: :created, location: @race }
      else
        format.html { render :new }
        format.json { render json: @Race.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /races/1
  # PATCH/PUT /races/1.json
  def update
    respond_to do |format|
      if @race.update(race_params)
        decode_results if race_params[:raw_results]
        format.html { redirect_to @race, notice: 'race was successfully updated.' }
        format.json { render :show, status: :ok, location: @race }
      else
        format.html { render :edit }
        format.json { render json: @Race.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /races/1
  # DELETE /races/1.json
  def destroy
    @race.destroy
    respond_to do |format|
      format.html { redirect_to races_url, notice: 'race was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def send_results
    if PERFORM_SENDING
      #on parse le champ hashtag pour découper les hashtags présents
      complete_hash_tag = ''
      if @race.hashtag
        hash_tags = @race.hashtag.strip.split(/\s+/)
        #on ajoute un # si absent du hashtag
        hash_tags.each do |hash_tag|
            complete_hash_tag = complete_hash_tag+"#{hash_tag.start_with?('#') ? '' : '#'}#{hash_tag} "
          end
      end

      @race.results.find_each do |result|
        SendResultJob.perform_later(result.id)
      end
      redirect_to races_url, notice: "#{@race.results.count} résultats en cours d'envoi." and return
    else
      redirect_to races_url, alert: "L'envoi des résutats est bloqué sur l'environnement de #{Rails.env}"
    end

  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_race
      @race = Race.find(params[:id])
    end

  def race_params
    params.require(:race).permit(
      :id,
      :name,
      :date,
      :email_sender,
      :email_name,
      :hashtag,
      :results_url,
      :sms_message,
      :raw_results,
      :background_image
    )
  end

  def decode_results
    content = race_params[:raw_results].read
    detection = CharlockHolmes::EncodingDetector.detect(content)
    utf8_encoded_content = CharlockHolmes::Converter.convert content, detection[:encoding], 'UTF-8'
    if utf8_encoded_content
      @race.results.delete_all
      CSV.parse(utf8_encoded_content, :headers => true, :col_sep => CSV_SEPARATOR) do |row|
        if row
          @race.results.create(
            phone: row[PHONE_INDEX],
            mail: row[MAIL_INDEX],
            rank: row[RANK_INDEX],
            name: Utils.titlecase(row[NAME_INDEX]),
            country: row[COUNTRY_INDEX],
            bib: row[NUMBER_INDEX],
            categ_rank: row[CATEG_RANK_INDEX],
            categ: row[CATEG_INDEX],
            sex_rank: row[SEX_RANK_INDEX],
            sex: row[SEX_INDEX],
            time: row[TIME_INDEX],
            speed: row[SPEED_INDEX],
            message: row[MESSAGE_INDEX],
            race_detail: row[RACE_DETAIL_INDEX]
          )
        end
      end
    end
  end

end
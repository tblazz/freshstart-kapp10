class RacesController < ApplicationController

  protect_from_forgery with: :exception,  except: :widget
  before_action :set_race, except: [:index, :new, :create]
  http_basic_authenticate_with name: ENV['ADMIN_LOGIN'], password: ENV['ADMIN_PASSWORD'], except: :widget

  def index
    @races = Race.order('date desc').paginate(:page => params[:page])
  end

  def new
    @race = Race.new(sms_message: I18n.t('sms_message_template'))
  end

  def show
  end

  def widget
    response.headers.except! 'X-Frame-Options'
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

  def generate_widget
    GenerateWidgetJob.perform_later(@race.id)
    redirect_to @race, notice: "Le widget est en cours de génération."
  end
  def generate_diplomas
    @race.generate_diplomas
    redirect_to @race, notice: "Les diplômes sont en cours de génération."
  end

  def delete_results
    @race.results.delete_all
    redirect_to @race, notice: "Les résultats ont été supprimés"
  end

  def duplicate
    @new_race = Race.create( name: @race.name + "_dup",
      date: @race.date,
      email_sender: @race.email_sender,
      email_name: @race.email_name,
      hashtag: @race.hashtag,
      results_url: @race.results_url,
      sms_message: @race.sms_message
    )
    redirect_to @new_race, notice: "La course est dupliquée."
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
      :background_image,
      :template
    )
  end

  def decode_results
    DecodeResultsFileJob.perform_later(@race.id)
  end
end
class EditionsController < ApplicationController
  before_action :set_edition, only: [:show, :edit, :update, :destroy, :results, :delete_results, :generate_widget]
  helper_method :sort_column, :sort_direction
  http_basic_authenticate_with name: ENV['ADMIN_LOGIN'], password: ENV['ADMIN_PASSWORD'], except: :widget

  def new
    @event = Event.find(params[:event_id])
    if params[:edition].blank?
      @edition = @event.editions.new(sms_message: I18n.t('sms_message_template'))
    else
      @edition = @event.editions.new(edition_params)
    end
  end

  def create
    @event = Event.find(params[:event_id])
    @edition = @event.editions.new(edition_params)
    if @edition.save
      redirect_to event_path(@edition.event), notice: "Edition créée !"
    else
      render :new
    end

    # @photos = params[:race][:photos]  || []
    # params[:race].delete(:photos)
    #
    # respond_to do |format|
    #   if @race.save
    #
    #     decode_results if race_params[:raw_results]
    #
    #     @photos.each do |photo|
    #       @race.photos.create({image: photo})
    #     end
    #
    #     format.html { redirect_to @race, notice: 'race was successfully created.' }
    #     format.json { render :show, status: :created, location: @race }
    #   else
    #     format.html { render :new }
    #     format.json { render json: @Race.errors, status: :unprocessable_entity }
    #   end
    # end
  end

  def show
  end

  def edit
  end

  def update
    if @edition.update(edition_params)
      updload_results if edition_params[:raw_results]
      redirect_to event_path(@edition.event), notice: "Edition mise à jour."
    else
      render :edit
    end
  end

  def destroy
    @edition.destroy
    respond_to do |format|
      format.html { redirect_to event_path(@edition.event), notice: "Edition effacée." }
    end
  end

  def generate_widget
    GenerateWidgetJob.perform_later(@edition.id)
    redirect_to event_path(@edition.event), notice: "Le widget est en cours de génération."
  end

  def results
    # raise @edition.inspect
    @runner = @edition.results.empty? ? Result.last : @edition.results.order("RANDOM()").limit(1).first
    @results = @edition.results.search(params[:search]).order(sort_column + ' ' + sort_direction).paginate(:per_page => 50, :page => params[:page])
    p @results.count
    # p @results.count
    # p @results.count
    # raise @results.inspect
  end

  def delete_results
    @edition.results.delete_all
    redirect_to event_path(@edition.event), notice: "Les résultats ont été supprimés"
  end

  private
  def set_edition
    @edition = Edition.find(params[:id])
  end

  def edition_params
    params.require(:edition).permit(
        :id,
        :date,
        :description,
        :email_sender,
        :email_name,
        :hashtag,
        :results_url,
        :sms_message,
        :raw_results,
        :background_image,
        :template,
        :external_link,
        :external_link_button,
        :event_id
    )
  end

  def sort_column
    @edition.results.column_names.include?(params[:sort]) ? params[:sort] : "rank"
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ?  params[:direction] : "asc"
  end

  def updload_results
    UploadResults.new(@edition.id).call
  end
end

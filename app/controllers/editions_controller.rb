class EditionsController < ApplicationController
  before_action :set_edition, only: [:show, :edit, :update, :destroy]

  def new
    @event = Event.find(params[:event_id])
    @edition = @event.editions.new(date: params[:date], description: params[:description])
  end

  def create
    @event = Event.find(params[:event_id])
    @edition = @event.editions.new(edition_params)
    if @edition.save
      redirect_to event_path(@edition.event), notice: "Edition créée !"
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @edition.update(edition_params)
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

  private
  def set_edition
    @edition = Edition.find(params[:id])
  end

  def edition_params
    params.require(:edition).permit(
        :id,
        :date,
        :description
    )
  end
end

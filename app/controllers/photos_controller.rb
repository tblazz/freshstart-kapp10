class PhotosController < ApplicationController
  before_action :set_event, only: %I[index create]
  before_action :set_edition, only: %I[index create]
  before_action :set_photo, only: %I[update]

  def index
    @photos = @edition.photos
  end

  def create
    @photo = @edition.photos.create! photo_params
  end

  def update
    respond_to do |format|
      if @photo.update(photo_params)
        format.js { render layout: false }
        format.html { redirect_to @photo, notice: 'photo was successfully updated.' }
        format.json { render :show, status: :ok, location: @photo }
      else
        format.html { render :edit }
        format.json { render json: @photo.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def set_event
    @event = Event.find params[:event_id]
  end

  def set_edition
    @edition = Edition.find params[:edition_id]
  end

  def set_photo
    @photo = Photo.find(params[:id])
  end

  def photo_params
    params.require(:photo).permit(
      :id,
      :bib,
      :direct_image_url
    )
  end
end

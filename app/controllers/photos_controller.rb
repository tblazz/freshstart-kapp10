class  PhotosController < ApplicationController

  def index
    @photos = Photo.where(race_id: params[:id])
  end

  def update
    @photo = Photo.find(params[:id])

    respond_to do |format|
      if @photo.update(photo_params)
        format.js {render layout: false}
        format.html { redirect_to @photo, notice: 'photo was successfully updated.' }
        format.json { render :show, status: :ok, location: @photo }
      else
        format.html { render :edit }
        format.json { render json: @photo.errors, status: :unprocessable_entity }
      end
    end
  end


  private

  def photo_params
    params.require(:photo).permit(
      :id,
      :bib)
  end

end

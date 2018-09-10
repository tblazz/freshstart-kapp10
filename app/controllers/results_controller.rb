class ResultsController < ApplicationController
  layout 'nude', only: [:show, :download]
  protect_from_forgery with: :exception
  http_basic_authenticate_with name: ENV['ADMIN_LOGIN'], password: ENV['ADMIN_PASSWORD'], except: [:show, :download]

  def diploma
    diploma = GenerateDiploma.new(params[:id])
    respond_to do |format|
      format.html {
        render inline: diploma.html
      }
      format.jpg {
        @result = Result.find(params[:id])
        diploma_image_data = diploma.image_kit(
          IMAGE_HEIGHT[@result.edition.template],
          IMAGE_WIDTH[@result.edition.template]
        ).to_img(:jpg)
        send_data diploma_image_data, type: "image/jpeg",
                                      disposition:'inline'
      }
    end
  end

  def show
    @result = Result.find(params[:id])
  end

  def download
    @result = Result.find(params[:id])
    quality = @result.purchased_at? || !@result.edition.download_chargeable? ? :original : :freemium
    respond_to do |format|
      format.jpg {  send_data(open(@result.diploma.url(quality), allow_redirections: :all).read,
                    type: 'image/jpeg',
                    filename: "#{@result.edition.event.name}-#{@result.first_name}-#{@result.last_name}.jpg",
                    disposition: 'attachment') }
    end
  end

  def stand_by
    @results = Result.where(runner_id: nil)
  end
end

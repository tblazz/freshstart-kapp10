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
        send_data(diploma.image_kit(IMAGE_HEIGHT[@result.edition.template],IMAGE_WIDTH[@result.edition.template]).to_img(:jpg), type: "image/jpeg", disposition:'inline')
      }
    end
  end

  def show
    @result = Result.find(params[:id])
    @page_url = request.original_url
    @facebook_link = "https://www.facebook.com/sharer/sharer.php?u=#{@page_url}"
    @twitter_message = "#{@result.race.name.capitalize} : les résultats de ma dernière course. "
    # @twitter_link = "https://twitter.com/home?status=#{URI.escape(@twitter_message + @page_url)}"
  end

  def download
    @result = Result.find(params[:id])
    respond_to do |format|
      format.jpg {  send_data(open(@result.diploma_url, allow_redirections: :all).read,
                    type: 'image/jpeg',
                    filename: "#{@result.edition.event.name}-#{@result.first_name}-#{@result.last_name}.jpg",
                    disposition: 'attachment') }
    end
  end

  def stand_by
    @results = Result.where(runner_id: nil)
  end
end

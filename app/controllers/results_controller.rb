class ResultsController < ApplicationController

  protect_from_forgery with: :exception
  http_basic_authenticate_with name: ENV['ADMIN_LOGIN'], password: ENV['ADMIN_PASSWORD']

  def diploma
    diploma = GenerateDiploma.new(params[:id])
    respond_to do |format|
      format.html {
        render inline: diploma.html
      }
      format.jpg {
        send_data(diploma.image_kit(1024,1024).to_img(:jpg), type: "image/jpeg", disposition:'inline')
      }
    end
  end
end

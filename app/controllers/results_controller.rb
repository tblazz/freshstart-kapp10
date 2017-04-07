class ResultsController < ApplicationController

  protect_from_forgery with: :exception

  def diploma
    diploma = GenerateDiploma.new(params[:id], 'texte-ombre')
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

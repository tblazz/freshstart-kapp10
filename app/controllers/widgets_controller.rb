class WidgetsController < ApplicationController
  protect_from_forgery with: :exception,  except: :show
  def show
    @race = Race.find(params[:id])
    respond_to do |format|
       format.js do
       end
    end
  end
end
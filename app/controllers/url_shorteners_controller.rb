class UrlShortenersController < ApplicationController
  def index
  end

  def delete_all
    UrlShorteners::DeleteAllUrlShortenersJob.perform_later

    redirect_to root_path, notice: "Lancement de la suppression des URL raccourcies."
  end
end

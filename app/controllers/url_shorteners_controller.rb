class UrlShortenersController < ApplicationController
  before_action :set_rebrandly_link_count, only: [:index]

  def index
  end

  def delete_all
    UrlShorteners::DeleteAllUrlShortenersJob.perform_later

    redirect_to root_path, notice: "Lancement de la suppression des URL raccourcies."
  end

  private

  def set_rebrandly_link_count
    api = Rebrandly::Api.new

    @rebrandly_link_count = api.link_count
  end
end

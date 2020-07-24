class UrlShortenersController < ApplicationController
  def index
  end

  def delete_all
    UrlShorteners::DeleteAllUrlShortenersService.new.call
  end
end

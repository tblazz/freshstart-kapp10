module UrlShorteners
  class DeleteAllUrlShortenersJob < ActiveJob::Base
    queue_as :normal

    def perform
      UrlShorteners::DeleteAllUrlShortenersService.new.call
    end
  end
end

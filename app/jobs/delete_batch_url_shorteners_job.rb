class DeleteBatchUrlShortenersJob < ActiveJob::Base
  queue_as :normal

  def perform(link_ids, batch_index = 0)
    UrlShorteners::DeleteBatchUrlShortenersService.new(link_ids, batch_index).call
  end
end

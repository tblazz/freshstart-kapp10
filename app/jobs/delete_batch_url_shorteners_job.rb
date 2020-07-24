class DeleteBatchUrlShortenersJob < ActiveJob::Base
  queue_as :normal

  def perform(csv_filename, batch_index = 0)
    UrlShorteners::DeleteBatchUrlShortenersService.new(csv_filename, batch_index).call
  end
end

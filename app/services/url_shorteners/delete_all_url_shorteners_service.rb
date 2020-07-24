module UrlShorteners
  class DeleteAllUrlShortenersService
    def call
      puts "### Build all url shorteners ###"
      BuildAllUrlShortenersService.new(csv_filename).call

      puts "### Delete all url shorteners ###"
      DeleteBatchUrlShortenersJob.perform_later(csv_filename)
    end

    private

    def csv_filename
      @csv_filename ||= "#{timestamp}_rebrandly_link_ids.csv"
    end

    def timestamp
      @timestamp ||= Time.now.to_i
    end
  end
end

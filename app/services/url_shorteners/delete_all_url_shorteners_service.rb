module UrlShorteners
  class DeleteAllUrlShortenersService
    def call
      build_all_url_shortener_link_ids
      launch_delete_of_url_shorteners_first_batch
    end

    private

    def build_all_url_shortener_link_ids
      puts "### Build all url shorteners ###"

      @link_ids = BuildAllUrlShortenerLinkIdsService.new.call
    end

    def launch_delete_of_url_shorteners_first_batch
      puts "### Delete all url shorteners ###"

      DeleteBatchUrlShortenersJob.perform_later(@link_ids)
    end
  end
end

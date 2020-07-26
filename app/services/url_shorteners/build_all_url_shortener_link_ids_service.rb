require 'csv'

module UrlShorteners
  class BuildAllUrlShortenerLinkIdsService
    def initialize(csv_filename = nil)
      @link_ids        = []
      @api_rate        = 10
      @number_by_batch = 25
    end

    def call
      batch_number.times do |i|
        puts "#{i + 1}/#{batch_number}"
        add_batch_link_ids
      end

      @link_ids
    end

    def add_batch_link_ids
      batch_links.each do |link|
        @link_ids << link.id
      end

      sleep waiting_time
    end

    def batch_links
      rebrandly_api.links(last: @link_ids.last)
    end

    def waiting_time
      @waiting_time ||= 1.to_f / @api_rate
    end

    def batch_number
      @batch_number ||= (rebrandly_api.link_count.to_f / @number_by_batch).ceil
    end

    def rebrandly_api
      @rebrandly_api ||= Rebrandly::Api.new
    end
  end
end

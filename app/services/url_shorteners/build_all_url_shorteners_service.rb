require 'csv'

module UrlShorteners
  class BuildAllUrlShortenersService
    def initialize(csv_filename = nil)
      @csv_filename    = csv_filename || "rebrandly_link_ids.csv"
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
      batch_links.each { |link| add_link(link.id) }

      sleep waiting_time
    end

    def add_link(link_id)
      csv_options = { col_sep: ',', force_quotes: true, quote_char: '"' }

      CSV.open(csv_filepath, 'ab', csv_options) do |csv|
        csv << [link_id]
      end

      @link_ids << link_id
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

    def csv_filepath
      @csv_filepath ||= "tmp/#{@csv_filename}"
    end
  end
end

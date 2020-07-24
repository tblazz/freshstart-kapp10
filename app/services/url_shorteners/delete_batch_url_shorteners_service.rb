require 'csv'

module UrlShorteners
  class DeleteBatchUrlShortenersService
    def initialize(csv_filename, batch_index = 0)
      @batch_index  = batch_index
      @api_rate     = 10
      @batch_size   = 500
      @csv_filename = csv_filename
    end

    def call
      return unless batch_link_ids

      puts "Batch index: #{@batch_index}"

      batch_link_ids.each_with_index do |link_id, index|
        puts "Url shortener n°#{batch_start + index}"
        rebrandly_api.delete(link_id)

        sleep waiting_time
      end

      DeleteBatchUrlShortenersJob.perform_later(@csv_filename, @batch_index + 1)
    end

    private

    def batch_start
      @batch_start ||= @batch_index * @batch_size
    end

    def batch_link_ids
      batch_end = (batch_start + @batch_size) - 1

      @batch_link_ids ||= link_ids[batch_start..batch_end]
    end

    def link_ids
      CSV.foreach(csv_filepath).to_a.flatten
    end

    def waiting_time
      @waiting_time ||= 1.to_f / @api_rate
    end

    def rebrandly_api
      @rebrandly_api ||= Rebrandly::Api.new
    end

    def csv_filepath
      @csv_filepath ||= "tmp/#{@csv_filename}"
    end
  end
end

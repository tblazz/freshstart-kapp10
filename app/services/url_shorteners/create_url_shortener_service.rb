module UrlShorteners
  class CreateUrlShortenerService
    def initialize(destination)
      @destination   = destination
      @rebrandly_api = Rebrandly::Api.new
    end

    def call
      return unless !@destination.empty? && domain

      rebrandly_link = @rebrandly_api.shorten(@destination, domain: domain.to_h)

      "http://#{rebrandly_link.short_url}"
    end

    private

    def domain
      @domain ||= BuildRebrandlyDomainService.new(rebrandly_api: @rebrandly_api).call
    end
  end
end

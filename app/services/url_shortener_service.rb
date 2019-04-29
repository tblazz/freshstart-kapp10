class UrlShortenerService
  def initialize(destination)
    @destination   = destination
    @rebrandly_api = Rebrandly::Api.new
    @domain        = @rebrandly_api.domains.first
  end

  def call
    return if @destination.empty?

    rebrandly_link = @rebrandly_api.shorten(@destination, domain: @domain.to_h)

    rebrandly_link.short_url
  end
end

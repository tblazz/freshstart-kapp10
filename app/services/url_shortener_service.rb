class UrlShortenerService
  def initialize(destination)
    @destination   = destination
    @rebrandly_api = Rebrandly::Api.new
  end

  def call
    rebrandly_link = @rebrandly_api.shorten(@destination)

    rebrandly_link.short_url
  end
end
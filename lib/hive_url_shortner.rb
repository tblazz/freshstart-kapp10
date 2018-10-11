class HiveUrlShortner

  def shorten(url)
    api_key = ENV['HIVE_API_KEY']
    query = "https://hive.am/api?api=#{api_key}&url=#{url}"

    response = RestClient::Request.new(
      method: :get,
      url: query
    ).execute

    JSON.parse(response)['short']
  end
end

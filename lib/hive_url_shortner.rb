require 'httparty'
class HiveUrlShortner

  def shorten(url)
    response = HTTParty.get("https://hive.am/api?api=#{ENV['HIVE_API_KEY']}&url=#{url}")
    JSON.parse(response.parsed_response)['short']
  end
end
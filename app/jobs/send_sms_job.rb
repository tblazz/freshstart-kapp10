class SendSmsJob < ActiveJob::Base
  queue_as :normal

  def perform(payload)
    url = URI.parse(SMS_PATH)
    req = Net::HTTP::Post.new(url.path)
    req.set_form_data({'login' => SMS_LOGIN, 'apiKey' => SMS_API_KEY, 'smsData' => payload}, '&')
    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true
    http.start { |http| http.request(req) }
  end
end
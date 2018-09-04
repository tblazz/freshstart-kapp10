if Rails.env.staging? || Rails.env.production?
  uri = URI.parse(ENV["REDIS_URL"])
  $redis = Redis.new(host: uri.host, port: uri.port, password: uri.password)
  $redis.ping
end

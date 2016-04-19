uri = URI.parse(ENV[REDIS_URL_VAR])
#$redis = Redis.new(:host => uri.host, :port => uri.port, :password => uri.password, :logger => Rails.logger)
$redis = Redis.new(:host => uri.host, :port => uri.port, :password => uri.password)
$redis.ping
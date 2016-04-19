Resque.redis=$redis
Dir[Rails.root.join("app/jobs/*.rb")].each { |file| require file }

# Resque.schedule = YAML.load_file(Rails.root.join('config', 'nba_resque_schedule.yml'))

#pour PostGreSQL
Resque.before_fork do
  defined?(ActiveRecord::Base) and
      ActiveRecord::Base.connection.disconnect!
end

Resque.after_fork do
  defined?(ActiveRecord::Base) and
      ActiveRecord::Base.establish_connection
end
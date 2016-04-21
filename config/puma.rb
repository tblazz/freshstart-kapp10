# config/puma.rb
environment ENV['RACK_ENV']
threads ENV['MIN_PUMA_WORKERS_COUNT'],ENV['MAX_PUMA_WORKERS_COUNT']

workers 1
preload_app!

on_worker_boot do
  ActiveSupport.on_load(:active_record) do
    ActiveRecord::Base.establish_connection
  end
end

on_restart do
  $redis.reconnect
end

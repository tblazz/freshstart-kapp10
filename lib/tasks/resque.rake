require 'resque'
require 'resque/tasks'
require 'resque/scheduler'
require 'resque_scheduler'
require 'resque_scheduler/tasks'

task "resque:setup" => :environment do
  ENV['QUEUE'] = '*' if ENV['QUEUE'].nil?
end

desc "Alias for resque:work (To run workers on Heroku)"
task "jobs:work" => "resque:work"

desc "Alias for resque:scheduler (To run workers on Heroku)"
task "jobs:schedule" => "resque:scheduler"
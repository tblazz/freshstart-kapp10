require 'resque'
require 'resque/tasks'

task "resque:setup" => :environment do
  ENV['QUEUE'] = '*' if ENV['QUEUE'].nil?
end

desc "Alias for resque:work (To run workers on Heroku)"
task "jobs:work" => "resque:work"
web: bundle exec puma -p $PORT -C ./config/puma.rb
worker: TERM_CHILD=1 RESQUE_TERM_TIMEOUT=10 QUEUES=*  bundle exec rake environment resque:work
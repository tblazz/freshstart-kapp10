source 'https://rubygems.org'
require 'rubygems'
ruby '2.4.1'


# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '5.0.2'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails'
gem 'pg', '~> 0.18.4' # Postgres SQL
gem 'jquery-rails'
gem 'turbolinks'
gem 'jbuilder', '~> 2.5'
gem 'sdoc', '~> 0.4.0', group: :doc
gem 'redis', '~> 3.3.3'
gem 'puma', '~> 3.4.0'
gem 'imgkit', '~> 1.6.1'
gem 'wkhtmltoimage-binary', '~> 0.12.2'
gem 'aws-sdk', '~> 2.3.0'
gem 'httparty', '~> 0.13.5'
gem 'newrelic_rpm'
gem 'charlock_holmes_bundle_icu', '~> 0.6.9.2'
gem 'bitly', '~> 0.10.4'
gem 'sidekiq' #gestionnaire de tâche de fond
gem 'sinatra', :require => false #for sidekiq
gem 'sidekiq-scheduler' # planificateur de tâche pr Sidekiq
gem 'simple_form'
gem "paperclip", "~> 5.0.0"
gem 'rack-cors', :require => 'rack/cors'
gem 'rollbar' # reporting des erreurs
gem 'bootstrap-sass'
gem 'htmlentities' # permet de transformer les accents en entités HTML ex: &eacute;
gem 'htmlcompressor' # permet de compresser le HTML  des widgets
gem 'will_paginate-bootstrap' # pagination
gem 'google_url_shortener'

group :development, :test do
  gem 'minitest-rails'
  gem 'dotenv-rails', '~> 2.1.1' # parsing du fichier ENV en dev
  gem 'minitest-rails-capybara'
  gem 'guard'
  gem 'guard-bundler'
  gem 'guard-rails'
  gem 'guard-minitest'
  gem 'timecop'
end

group :development do
  gem "letter_opener"
  gem 'annotate'
end

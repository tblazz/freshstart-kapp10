require 'sidekiq/web'
require 'sidekiq-scheduler/web'

Rails.application.routes.draw do

  get 'result/new', to: 'result#new'
  post 'result', to: 'result#create'
  resources :races

  root :to => 'result#new'

  #montage de la gem gérant Messenger
  mount MessageQuickly::Engine, at: "/messenger_webhook"

  # config/routes.rb
  Sidekiq::Web.use Rack::Auth::Basic do |username, password|
    username == ENV['ADMIN_LOGIN'] && password == ENV['ADMIN_PASSWORD']
  end
  mount Sidekiq::Web, at: '/jobs'

end
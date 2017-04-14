require 'sidekiq/web'
require 'sidekiq-scheduler/web'

Rails.application.routes.draw do
  get 'result/:id/diploma', to: 'results#diploma', as: 'result_diploma'
  resources :races do
    member do
      post 'send_results'
      post 'duplicate'
      post 'generate_widget'
      get 'diploma'
      get 'widget'
      delete 'delete_results'
    end
  end

  root :to => 'races#index'

  # config/routes.rb
  Sidekiq::Web.use Rack::Auth::Basic do |username, password|
    username == ENV['ADMIN_LOGIN'] && password == ENV['ADMIN_PASSWORD']
  end
  mount Sidekiq::Web, at: '/jobs'

end
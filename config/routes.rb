require 'sidekiq/web'
require 'sidekiq-scheduler/web'

Rails.application.routes.draw do
  get 'widget', to: redirect('/widget.js')
  get 'client_widget', to: redirect('/widget-client.js')
  get 'client_widget_css', to: redirect('/widget-client.css')
  get 'challenge_widget', to: redirect('/widget-challenge-test.js')

  get 'result/:id/diploma', to: 'results#diploma', as: 'result_diploma'
  get 'results/:id/download', to: 'results#download', as: 'download_diploma'
  get 'results_stand_by', to: 'results#stand_by', as: 'stand_by'
  resources :races do
    member do
      post 'send_results'
      post 'duplicate'
      post 'generate_widget'
			post 'generate_photos_widget'
      post 'generate_diplomas'
			get 'regenerate_all_widgets'
      delete 'delete_diplomas'
      get 'diploma'
      get 'widget'
			get 'photos_widget'
      delete 'delete_results'
      get 'pairing', to: 'photos#index'
    end
  end

  get 'events/upload', to: 'events#upload', as: 'upload_events'
  post 'events/import', to: 'events#import', as: 'import_events'

  resources :events do
    resources :editions do
      member do
        get 'results'
        post 'send_results'
        post 'duplicate'
        post 'generate_widget'
        post 'generate_photos_widget'
        post 'generate_diplomas'
        get 'regenerate_all_widgets'
        delete 'delete_diplomas'
        get 'diploma'
        get 'widget'
        get 'photos_widget'
        delete 'delete_results'
        get 'pairing', to: 'photos#index'
      end
    end
  end

  resources :photos
  resources :results, only: :show
  resources :runners, only: [:index, :show]
  resources :clients do
    member do
      get 'generate_widget'
    end
  end

  get 'challenges/update_scores', to: 'challenges#update_scores', as: 'update_scores'
  get 'challenges/generate_global_widget', to: 'challenges#generate_global_widget', as: 'generate_global_widget'
  resources :challenges do
    member do
      get 'generate_widget'
    end
  end

  root :to => 'events#index'

  # config/routes.rb
  Sidekiq::Web.use Rack::Auth::Basic do |username, password|
    username == ENV['ADMIN_LOGIN'] && password == ENV['ADMIN_PASSWORD']
  end
  mount Sidekiq::Web, at: '/jobs'

end

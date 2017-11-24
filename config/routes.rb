require 'sidekiq/web'
require 'sidekiq-scheduler/web'

Rails.application.routes.draw do
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

  root :to => 'events#index'

  # config/routes.rb
  Sidekiq::Web.use Rack::Auth::Basic do |username, password|
    username == ENV['ADMIN_LOGIN'] && password == ENV['ADMIN_PASSWORD']
  end
  mount Sidekiq::Web, at: '/jobs'

end

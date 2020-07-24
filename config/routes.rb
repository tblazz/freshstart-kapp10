require 'sidekiq/web'
require 'sidekiq-scheduler/web'

Rails.application.routes.draw do
  get 'widget', to: redirect('/widget3.js')
  get 'client_widget', to: redirect('/widget-client.js')
  get 'client_widget_css', to: redirect('/widget-client.css')
  get 'challenge_widget', to: redirect('/widget-challenge-test.js')
  get 'result/:id/diploma', to: 'results#diploma', as: 'result_diploma'
  get 'results/:id/download', to: 'results#download', as: 'download_diploma'
  get 'results_stand_by', to: 'results#stand_by', as: 'stand_by'
  get 'results/:id/emaildiploma', to: 'results#email_diploma'
  get 'diploma_thumbnail', to: 'results#diploma_thumbnail'
  post 'results/process_diploma_email', to: 'results#process_diploma_email'
  get 'mail_viewers/result/:id', to: 'mail_viewers#result', as: 'result_mail_viewer'

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
      get 'diplomas_widget'
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
        post 'generate_diplomas_widget'
        post 'generate_diplomas'
        get 'regenerate_all_widgets'
        delete 'delete_diplomas'
        get 'diploma'
        get 'widget'
        get 'photos_widget'
        get 'diplomas_widget'
        delete 'delete_results'
        get 'pairing', to: 'photos#index'
      end

      resources :photos, only: %I[index create destroy] do
        collection do
          delete :destroy_all
        end
      end
    end
  end

  resources :photos, only: %I[show update destroy]

  resources :results, only: :show do
    resource :payment, only: [:show, :create]
  end
  resources :runners, only: [:index, :show, :update]
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

  resources :url_shorteners, only: [:index] do
    collection do
      delete 'delete_all'
    end
  end

  #############################
  # Routes pour l'API
  #############################

  use_doorkeeper do
    # it accepts :authorizations, :tokens, :applications and :authorized_applications
    controllers :applications => 'freshstart_applications'
  end

  namespace :api, :defaults => {:format => :json} do
    namespace :v1 do

      concern :result_attachable do
        resources :results
      end

      concern :photo_attachable do
        resources :photos
      end

      resources :events do
        resources :editions, shallow: true
      end

      resources :details, only: [:index]

      resource :search, only: [:show]

      resources :editions, concerns: [:result_attachable, :photo_attachable] do
        resources :races, shallow: true, concerns: [:result_attachable, :photo_attachable]
      end

      resources :runners, concerns: [:result_attachable]

    end

    namespace :v2 do
      resources :editions,         only: [:index, :show] do
        resources :races,          only: [:index]
      end

      resources :races,            only: [:index]
      get 'calendar',              to: 'editions#calendar'
      get 'editions_search_list',  to: 'editions#search_list'

      resources :events,           only: [:index]
      resources :runners,          only: [:index, :show]
      get 'runners_search_list',   to: 'runners#search_list'
      resources :featured_runners, only: [:index]
    end
  end

  #############################
  # /Routes pour l'API
  #############################

  root :to => 'events#index'

  # config/routes.rb
  Sidekiq::Web.use Rack::Auth::Basic do |username, password|
    username == ENV['ADMIN_LOGIN'] && password == ENV['ADMIN_PASSWORD']
  end
  mount Sidekiq::Web, at: '/jobs'

  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: '/letter_opener'
  end
end

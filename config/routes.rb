Rails.application.routes.draw do
  # get 'result/', to: 'result#get'
  get 'result/new', to: 'result#new'
  post 'result', to: 'result#create'


  mount Resque::Server, at: 'jobs'
  root :to => 'result#new'
end

Rails.application.routes.draw do
  get 'posts/new'

get '/login', to: 'sessions#new'
delete '/logout', to: 'sessions#destroy'
post '/login', to: 'sessions#create'
get '/signup', to: 'users#new'
post '/member', to:'users#member'
resources :users
resources :posts



end

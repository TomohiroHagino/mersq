Rails.application.routes.draw do
  root 'static_pages#top'
  get '/login', to: 'users#login'
end
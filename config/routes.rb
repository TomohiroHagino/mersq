Rails.application.routes.draw do
  root 'static_pages#top'
  get 'sessions/new'
  
  get '/signup', to: 'users#new'

  # ヘッダーメニュー
  get '/scrayping',     to: 'users#scrayping'
  get '/how_to_use',     to: 'users#how_to_use'

  # ログイン機能
  get    '/login', to: 'sessions#new'
  post   '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  # Restful
  resources :users
end

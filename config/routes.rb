Rails.application.routes.draw do
  root 'static_pages#top'
  get 'sessions/new'

  get '/signup', to: 'users#new'

  # ログイン機能
  get    '/login', to: 'sessions#new'
  post   '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  # Restful
  resources :users

  #スクレイピング
  get 'users/:id/scrape',     to: 'users#scrape', as: :scrape
  #CSVエクスポート
  get 'users/:id/csv_export',     to: 'users#csv_export', as: :csv_export
  #一部商品の削除
  post 'users/:id/',     to: 'items#delete', as: :item_delete
  # ヘッダーメニュー
  get 'users/:id/how_to_use',     to: 'users#how_to_use', as: :users_how_to_use
  # Youtubeスクレイピング
  get 'users/:id/youtube_scrape',     to: 'users#youtube_scrape', as: :youtube_scrape 
end

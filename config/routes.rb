Rails.application.routes.draw do
  root "site_pages#index"
  namespace :admin do
    root to: "pages#home"
    resources :users
    resources :albums
    resources :categories
    resources :songs
    resources :lyrics
    resources :artists
  end
end

Rails.application.routes.draw do
  root "site_pages#index"
  get "password_reset/new"
  get "password_reset/edit"
  get "/signup", to: "users#new"
  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"
  post "/songs", to: "songs#audio_download"
  post "songs/next", to: "songs#next"
  resources :account_activations, only: :edit
  resources :songs, only: :show
  resources :lyrics, only: :create
  resources :password_resets, only: [:new, :create, :edit, :update]
  resources :users, except: :index
  resources :lyrics, only: :create
  resources :comments
  resources :categories, only: [:show, :index]
  resources :artists, only: [:show, :index]
  resources :albums, only: [:show, :index]
  resources :favorites
  resources :favorite_songs
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

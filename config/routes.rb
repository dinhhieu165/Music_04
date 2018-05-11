Rails.application.routes.draw do
  get 'songs/show'

  get 'songs/index'

  root "site_pages#index"
  resources :category, only: [:show, :index]
end

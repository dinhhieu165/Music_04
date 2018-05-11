Rails.application.routes.draw do
  root "site_pages#index"
  resources :category, only: [:show, :index]
end

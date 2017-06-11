Rails.application.routes.draw do
  # get 'image/show'

  # post 'image/create'

  root 'users#index'
  resources :users, only: [:create]
  resources :images, only: [:create]
end

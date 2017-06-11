Rails.application.routes.draw do
  # get 'photo/create'

  # get 'image/show'

  # post 'image/create'

  root 'users#index'
  resources :users, only: [:create]
  resources :photos, only: [:create]
end

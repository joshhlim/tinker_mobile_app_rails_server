Rails.application.routes.draw do
  devise_for :users
  # , :path => 'u'
  devise_scope :user do
  get 'logout', to: 'devise/sessions#destroy'
end
  resources :users, only: [:show] do
    resources :requests, only: [:new, :create, :show, :index]
  end

  resources :users, only: [:show] do
    resources :profile_photo, only: [:new, :create, :show, :index]
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :chat_rooms, only: [:new, :create, :show, :index]
  root 'chat_rooms#index'
  mount ActionCable.server => '/cable'

  get 'callback/index'

  resources :profile

  get "/privacy-policy" => "policy#index"
  get "/ig/callback" => "callback#index"
end

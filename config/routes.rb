Rails.application.routes.draw do
  resources :users, only: [:show] do
    resources :requests, only: [:new, :create, :show, :index]
  end

  resources :users, only: [:show, :create] do
    resources :profile_photo, only: [:new, :create, :show, :index]
  end

  resources :requests, only: [:show] do
    resources :user_requests, only: [:index, :show, :create, :new]
  end

  get 'callback/index'

  post 'authenticate', to: 'authentication#authenticate'

  get "/privacy-policy" => "policy#index"
  get "/ig/callback" => "callback#index"

end

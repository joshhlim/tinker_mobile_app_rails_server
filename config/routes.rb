Rails.application.routes.draw do
  resources :users, only: [:show] do
    resources :requests, only: [:new, :create, :show, :index, :edit, :update] do
      resources :comments, only: [:new, :create, :show, :index, :edit, :update]
    end
    resources :user_requests, only: [:index]
  end

  resources :users, only: [:show, :create, :new, :index] do
    resources :profile_photos, only: [:new, :create, :show, :index]
  end

get '/requests/advise', to: 'user_requests#index'

  post 'authenticate', to: 'authentication#authenticate'

  get "/privacy-policy" => "policy#index"
  get "/ig/callback" => "callback#index"

end

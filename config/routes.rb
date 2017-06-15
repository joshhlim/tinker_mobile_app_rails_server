Rails.application.routes.draw do
  get '/requests/advise', to: 'user_requests#index'

  get "/privacy-policy" => "policy#index"
  get "/ig/callback" => "callback#index"




  resources :users, only: [:new, :create, :show, :index, :edit, :update] do
    resources :requests, only: [:new, :create, :show, :index, :edit, :update] do
      resources :comments, only: [:new, :create, :show, :index, :edit, :update]
    end
    # resources :user_requests, only: [:index]
  end

  resources :profile_photos

  resources :requests, only: [:show, :edit, :update, :delete]

  post '/request_photo_upload', to: 'requests#photo_upload'


  put '/requests', to: 'requests#update'

  post 'authenticate', to: 'authentication#authenticate'


end

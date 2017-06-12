class CallbackController < ApplicationController
  def index
    # binding.pry
    # render nothing: true, status: 200
    response = Instagram.get_access_token(params[:code], redirect_uri: "http://localhost:3000/ig/callback")
    # redirect_uri: "https://tinkrfashion.herokuapp.com/ig/callback"
    session[:access_token] = response.access_token
    redirect_to root_path
  end
end

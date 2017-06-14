class ApplicationController < ActionController::Base
  # protect_from_forgery with: :exception
  before_action :authenticate_request
  attr_reader :current_user

  private
    def current_user
       @current_user = AuthorizeApiRequest.call(request.headers).result
    end

    def logged_in?
      !current_user.nil?
    end

    def create_action_failure
      head 422
    end

    def authenticate_request
      puts "headers['Authorization'] => #{request.headers['Authorization']}"
      puts "headers['Accept'] => #{request.headers['Accept']}"
      @current_user = AuthorizeApiRequest.call(request.headers).result
      render json: { error: 'Not Authorized' }, status: 401 unless @current_user
    end
end

class ApplicationController < ActionController::Base
  # protect_from_forgery with: :exception
  # before_action :must_login
  before_action :authenticate_request
  attr_reader :current_user

  private
    def login(user)
      session[:user_id] = user.id
    end

    def current_user
       @current_user ||= User.find(session[:user_id]) if session[:user_id]
    end

    def logged_in?
      !current_user.nil?
    end

    def must_login
      redirect_to login_url, alert: 'You must login to access that page' unless logged_in?
    end

    def create_action_failure
      head 422
    end

    def authenticate_request
      @current_user = AuthorizeApiRequest.call(request.headers).result
      render json: { error: 'Not Authorized' }, status: 401 unless @current_user
    end
end

class UsersController < ApplicationController
  # skip_before_action :verify_authenticity_token, only: [:create]
  def index
  end

  def new
    @user = User.new
  end

  def show
    puts params
    puts "/n/n/n"
    @user = current_user
    # @styles = UserStyle.where(user:current_user)
  end

  def notifications
    @advice_requests = current_user.advice_requests
  end

  def requests
    @requests = current_user.requests
  end

  def browse

  end

  def create
    puts params
    create_action_failure and return unless params.has_key?(:user) && params[:user].present?
    user = User.new(user_params)
    if user.save
      login(user)
      render json: user.to_json
    else
      create_action_failure
    end
  end

private
  def user_params
      params.require(:user).permit(:username, :email, :password, :password_confirmation)
  end

  def create_action_failure
    head 422
  end
end

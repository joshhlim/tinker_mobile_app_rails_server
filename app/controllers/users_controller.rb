class UsersController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:create]
  def index
  end

  def new
    @user = User.new
  end

  def show
    @user = current_user
    @styles = User_styles.where(user:current_user)
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

class UsersController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:create]

  def create
    puts params.inspect
    create_action_failure and return unless params.has_key?(:user) && params[:user].present?
    @user = User.new(user_params)
    if @user.save
      render json: @user.to_json
    else
      create_action_failure
    end
  end

private
  def user_params
      params.require(:user).permit(:username)
  end

  def create_action_failure
    head 422
  end
end

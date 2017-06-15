class UsersController < ApplicationController
  skip_before_action :authenticate_request, only: [:new, :create]

  def index
    user = User.all
    render json: user.to_json(include: [profile_photos: { methods: :image, only: [:id] } ])
  end

  def new
    @user = User.new
  end

  def edit
    current_user
  end

  def show
    render json: current_user.to_json(include:
      [
        { profile_photos: { methods: :image, only: [:id] } }
      ])
    # @styles = UserStyle.where(user:current_user)
  end

  def create
    puts params
    create_action_failure and return unless params.has_key?(:user) && params[:user].present?
    user = User.new(user_params)
    if user.save
      command = AuthenticateUser.call(params[:user][:username], params[:user][:password])
      if command.success?
        render json: { user: user, auth_token: command.result, id: user.id }.to_json
      else
        render json: { error: command.errors }, status: :unauthorized
      end
    else
      create_action_failure
    end
  end

  def update
    params[:user][:friends].each do |friend_id|
      current_user.friends << User.find(friend_id)
    end
    params[:user][:experts].each do |expert_id|
      current_user.experts << User.find(expert_id)
    end
    render json: current_user.to_json
  end

private
  def user_params
      params.require(:user).permit(:username, :email, :password, :password_confirmation)
  end

  def create_action_failure
    head 422
  end
end

class UsersController < ApplicationController
  skip_before_action :authenticate_request, only: [:create]
  # skip_before_action :verify_authenticity_token, only: [:create]
  # skip_before_action :authenticate_request, only: [:create]
  def index
    users = User.all
    render json: user.to_json(include: [{request: Request.last}])
  end

  def new
    @user = User.new
  end

  def show
    render json: current_user.to_json(include:
      [
        { profile_photos: { methods: :image, only: [:id] } }
      ])
    # @styles = UserStyle.where(user:current_user)
  end

  # def browse

  # end

  def create

    puts params
    create_action_failure and return unless params.has_key?(:user) && params[:user].present?
    user = User.new(user_params)
    if user.save
      # render json: current_user.to_json
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

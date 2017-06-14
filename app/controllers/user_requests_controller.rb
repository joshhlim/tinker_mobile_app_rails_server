class UserRequestsController < ApplicationController
  def index
    advice_requests = current_user.advice_requests.as_json
    render json: current_user.advice_requests.to_json(include:
      [
        { request_photos: { methods: :image, only: [:id] } },
        { advisors: { only: :username } }
      ])
  end

  def new
    @user_request = UserRequest.new
  end

  def show
  end

  def create
    # request = params[:request_id]
    # advisors = params[:user_request][:advisors]
    # advisors.each{ |advisor| UserRequest.create(user: User.find_by(username:advisor), request: request) }

    # advisors.length.times do
    #   UserRequest.create(user_request_params)
    # end

    user_request = UserRequest.new(user_request_params)
    if user_request.save
      render json: user_request.to_json
    else
      create_action_failure
    end

  end

  private
  def user_request_params
    params.require(:user_request).permit(:user_id, :request_id)
  end

end

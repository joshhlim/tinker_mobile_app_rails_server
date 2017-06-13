class UserRequestsController < ApplicationController
  # skip_before_action :verify_authenticity_token, only: [:create]
  def index
    render json: current_user.advice_requests.to_json(include:
      [
        { request_photos: { methods: :image, only: [:id] } },
        { advisors: { only: :username } }
      ])
  end

  def show
  end

  def create
    advisors = params[:advisors]
    request = params[:request]
    advisors.each{ |advisor| User_request.create(user: User.find_by(username:advisor), request: request) }
  end


end

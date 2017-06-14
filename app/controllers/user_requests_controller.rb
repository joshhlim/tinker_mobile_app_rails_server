class UserRequestsController < ApplicationController
  def index
    render json: current_user.advice_requests.to_json(include:
      [
        { request_photos: { methods: :image, only: [:id] } },
        { advisors: { only: :username } }
      ])
  end

  def new
  end

  def show
  end

  def create
    request = params[:request_id]

    advisors.each{ |advisor| UserRequest.create(user: User.find_by(username:advisor), request: request) }
  end


end

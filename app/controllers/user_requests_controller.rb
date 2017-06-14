class UserRequestsController < ApplicationController
  def index
    advice_requests = current_user.advice_requests
    render json: current_user.advice_requests.to_json(include:
      [
        { request_photos: { methods: :image, only: [:id] } },
        { user: {only: [:username]} }
        # { advisors: { only: [:username, :id] } },
        # { comments: { only: [:body, :user_id, :request_photo_id]}}
      ])
  end

  def show
  end
end

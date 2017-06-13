class UserRequestsController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:create]
  def index
  end

  def show
  end

  def create
    request = params[:request]
    request_photo = params[:request_photo]
    body = params[:body]
    comment = Comment.new(user: current_user, request: request, request_photo: request_photo, body: body)
    if comment.save
      render json: comment.to_json
    else
      create_action_failure
    end
  end


end

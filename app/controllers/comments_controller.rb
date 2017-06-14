class UserRequestsController < ApplicationController
  def index
  end

  def show
  end

  def create
    puts params
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

  private
  def comment_params
      #params.require(:request).permit(:description, :user_id)
      params.require(:comment).permit!
  end

end

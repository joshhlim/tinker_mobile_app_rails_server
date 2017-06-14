class CommentsController < ApplicationController
  def index
    request = Request.find(params[:request_id])
    comments = request.comments
    render json: comments.to_json
  end

  def show
    comment = Comment.find(params[:id])
    render json: comment.to_json(include:
      [
        { request_photo: { methods: :image, only: [:id] } }
      ])
  end

  def new
    request = Request.find(params[:request_id])
    comment = Comment.new
    render_request_as_json(request)
  end

  def edit

  end

  def create
    request = Request.find(params[:request_id])
    comment = Comment.new(comment_params)
    request.comments << comment
    render_request_as_json(request)
  end

  def update
  end


  private
  def comment_params
      params.require(:comment).permit(:body, :user_id, :request_photo_id, :request_id)
  end

  def render_request_as_json(request)
    request_as_json = request.as_json(include:
      [
        { request_photos: { methods: :image, only: [:id] } },
        { advisors: { only: [:username, :id] } },
        { comments: { only: [:body, :user_id, :request_photo_id]}}
      ])
    render json: request_as_json.to_json
  end
end

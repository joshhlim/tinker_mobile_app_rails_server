class RequestsController < ApplicationController
  def index
    requests = current_user.requests
    render json: requests.to_json(include: [request_photos: { methods: :image, only: [:id] }])
  end

  def show
    request = Request.find(params[:id])
    render_request_as_json(request)
  end

  def new
    @request = Request.new
  end

  def edit
    request = Request.find(params[:id])
    render_request_as_json(request)
  end

  def create
    create_action_failure and return unless params.has_key?(:request) && params[:request].present?
    @request = Request.new(request_params)
    @request.user = current_user

    @request_photo = RequestPhoto.new(request_photo_params)
    @request.request_photos << @request_photo

    if @request.save
      render json: @request.to_json
    else
      create_action_failure
    end
  end

  def update
    request = Request.find(params[:id])
    params[:user_request][:advisors].each do |advisor_id|
      request.advisors << User.find(advisor_id)
    end
    render_request_as_json(request)
  end

private
  def request_params
      params.require(:request).permit!
  end

  def request_photo_params
    params.require(:request_photo).permit!
  end

  def create_action_failure
    head 422
  end

  def render_request_as_json(request)
    users = User.all - request.advisors - [current_user]
    friends = current_user.friends - request.advisors
    experts = current_user.experts - request.advisors
    request_as_json = request.as_json(include:
      [
        { request_photos: { methods: :image, only: [:id] } },
        { user: {only: [:username]} },
        { advisors: { only: [:username, :id] } },
        { comments: { methods: :user, only: [:body, :user_id, :request_photo_id]}}
      ])
    render json: { request: request_as_json, users: users.as_json(only: [:id, :username]), friends: friends.as_json(only: [:id, :username]), experts: experts.as_json(only: [:id, :username]) }.to_json
  end
end

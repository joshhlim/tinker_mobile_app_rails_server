class RequestsController < ApplicationController
  def index
    requests = current_user.requests
    render json: requests.to_json(include: [request_photos: { methods: :image, only: [:id] }])
  end

  def show
    request = Request.find(params[:id])
    # friends = current_user.friends - request.advisors
    # experts = current_user.followed_experts
    render_request_as_json(request)
  end

  def new
    @request = Request.new
  end

  def edit
    request = Request.find(params[:id])
    render_request_as_json(request)
  end

  def photo_upload
    request = Request.find_by(id: params[:request_id], user: current_user) || Request.new(user: current_user)
    request_photo = RequestPhoto.new(image: params[:photo])
    request.request_photos << request_photo
    request.save!
    render json: request.to_json(include: :request_photos)
  end

  def create
    create_action_failure and return unless params.has_key?(:request) && params[:request].present?
    @request = Request.new(request_params)
    puts "\n\n\nrequest"
    p @request

    @request.user = current_user

    @request_photo = RequestPhoto.new(request_photo_params)
    puts "\n\n\nrequest photo"
    p @request_photo
    @request.request_photos << @request_photo

    if @request.save
      render json: @request.to_json
    else
      create_action_failure
    end
  end

  def update
    request = Request.find(request_params[:id])
    if request_params[:description]
      request.description = request_params[:description]
      request.save
    elsif request_params[:advisors]
      puts "this is obvious \n\n\n"
      puts request_params.inspect
      request_params[:advisors].each do |advisor|
        new_advisor = User.find_by(advisor)
        request.advisors << new_advisor if new_advisor
      end
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
    request_as_json = request.as_json(include:
      [
        { request_photos: { methods: :image, only: [:id] } },
        { advisors: { only: [:username, :id] } },
        { comments: { only: [:body, :user_id, :request_photo_id]}}
      ])
    render json: { request: request_as_json, users: users.as_json(only: [:id, :username]) }.to_json
  end
end

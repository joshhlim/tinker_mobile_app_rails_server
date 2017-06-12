class RequestsController < ApplicationController

  skip_before_action :verify_authenticity_token, only: [:create]
  def index
  end
  def new
    @user = User.find(2)
    @request = Request.new
  end

  def create
    create_action_failure and return unless params.has_key?(:request) && params[:request].present?
    @request = Request.new(request_params)
    @request.user = current_user
    @request.request_photos.build(request_photos_params)
    #you will need to create request photos here with @request.id as request_id
    if @request.save
      render json: @request.to_json
    else
      create_action_failure
    end
  end

private
  def request_params
      params.require(:request).permit(:description)
  end

  def request_photos_params
    params.require(:request).require(:request_photos, array: [:url])#might be an array of images with paperclip
  end

  def create_action_failure
    head 422
  end
end

class ProfilePhotosController < ApplicationController
  def index
    render json: current_user.profile_photos.to_json
  end

  def show
  end

  def new
  end

  def create
    create_action_failure and return unless params.has_key?(:profile_photo) && params[:profile_photo].present?
    @profile_photo = Profile_photo.new(profile_photo_params)
    @profile_photo.user = current_user
# start with instagram urls probably
    if @profile_photo.save
      render json: @profile_photo.to_json
    else
      create_action_failure
    end
  end

  def edit
  end

  def update
  end

  def delete
  end

private
  def profile_photo_params
      params.require(:profile_photo).permit!
  end

  def create_action_failure
    head 422
  end
end

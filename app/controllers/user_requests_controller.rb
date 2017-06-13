class UserRequestsController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:create]
  def index
  end

  def show
  end

  def create
    advisors = params[:advisors]
    request = params[:request]
    advisors.each{ |advisor| User_request.create(user: User.find_by(username:advisor), request: request) }
  end


end

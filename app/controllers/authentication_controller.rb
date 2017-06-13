class AuthenticationController < ApplicationController
  skip_before_action :authenticate_request

  def authenticate
    puts "BUG HUNTER"
    puts "test"
    puts "1"
    puts "2"
    puts "3"
    command = AuthenticateUser.call(params[:user][:username], params[:user][:password])

    if command.success?
      render json: { auth_token: command.result }
    else
      render json: { error: command.errors }, status: :unauthorized
    end
  end
end

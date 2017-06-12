class ProfilesController < ApplicationController
  before_filter :authenticate_user!

  def show
    @user=current_user
    @user.email = nil unless @user.email.scan('@example.com').empty?
    render 'devise/profile/edit'
  end

  def update
    @user=current_user
    if @user.update_attributes(params[:user])
        sign_in 'user', @user, :bypass => true
        flash[:notice] = t('users.profile.edit.updated')
        respond_to do |format|
            format.html { redirect_to '/'}
        end
    else
      render 'devise/profile/edit'
    end
  end
end

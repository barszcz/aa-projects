class SessionsController < ApplicationController
  def new
    @user = User.new
    render :new
  end

  def create
    @user = User.find_by_credentials(params[:user][:username], params[:user][:password])

    if @user.nil?
      render :new
    else
      @user.reset_session_token!
      log_in!(@user)
      redirect_to cats_url
    end
  end

  def destroy
    @user = current_user
    
    session[:session_token] = nil
    @user.reset_session_token!
    log_out!(@user)

    redirect_to new_session_url
  end
end

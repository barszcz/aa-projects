class SessionsController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.find_by_credentials(params[:session][:username], params[:session][:password])
    # fail
    if @user
      log_in!(@user)
      redirect_to user_url(@user)
    else
      flash.now[:errors] = ["Invalid username/password"]
      render :new
    end
  end


end

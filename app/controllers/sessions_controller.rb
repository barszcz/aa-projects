class SessionsController < ApplicationController
  def new
  end

  def create
    @user = User.find_by_credentials(
                                     params[:session][:email],
                                     params[:session][:password]
                                     )
    if @user
      log_in!(@user)
      redirect_to user_url(@user)
    else
      flash.now[:errors] = ["Invalid username or password."]
      render :new
    end
  end

  def destroy
    log_out!
    render :new
  end
end

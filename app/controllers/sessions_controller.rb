class SessionsController < ApplicationController
  def new
  end

  def create
    @user = User.find_by_credentials(
                                     params[:session][:email],
                                     params[:session][:password]
                                     )
    if @user.activated?
      log_in!(@user)
      redirect_to user_url(@user)
    elsif @user
      flash.now[:errors] = ["Please activate your account."]
      render :new
    else
      flash.now[:errors] = ["Invalid username or password."]
    end
  end

  def destroy
    log_out!
    render :new
  end
end

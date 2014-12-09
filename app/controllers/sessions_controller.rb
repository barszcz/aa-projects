class SessionsController < ApplicationController


  def create
    @user = User.find_by_credentials(params[:name],params[:password])
    log_in!(@user)
    render text: "logged in"
  end

  def destroy

    log_out!
  end
end

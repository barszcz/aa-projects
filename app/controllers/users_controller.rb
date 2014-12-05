class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save

      log_in!(@user)
      redirect_to cats_url
    else
      render json: @user.errors.full_messages
    end
  end

  def show
    if current_user.nil?
      redirect_to new_session_url
      return
    end

    @user = current_user
    render json: @user
  end

  private

  def user_params
    params.require(:user).permit(:username, :password)
  end
end

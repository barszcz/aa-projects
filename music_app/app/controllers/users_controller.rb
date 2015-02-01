class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      email = Activation.activation_email(@user)
      email.deliver
      render text: "You're signed up! Check your email for your activation link."
    else
      flash[:errors] = @user.errors.full_messages
      render :new
    end
  end

  def activate
    @user = User.find_by(activation_token: params[:token])
    if @user
      @user.activate!
      log_in!(@user)
      render :show
    else
      render text: "Invalid activation token."
    end
  end

  private

  def user_params
    params.require(:user).permit([:email, :password])
  end
end

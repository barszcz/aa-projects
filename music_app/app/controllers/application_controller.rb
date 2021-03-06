class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_user, :logged_in?

  def current_user
    @current_user ||= User.find_by(session_token: session[:session_token])
  end

  def logged_in?
    !!current_user
  end

  def log_in!(user)
    @current_user = user
    session[:session_token] = @current_user.reset_session_token!
  end

  def log_out!
    session[:session_token] = nil
    current_user.try(:reset_session_token!)
  end

  def ensure_logged_in
    redirect_to new_session_url unless logged_in?
  end

  def ensure_admin
    redirect_to bands_url unless current_user.admin?
  end
end

class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def require_cat_belongs_to_user
    if self.class == CatRentalRequestsController
      id = CatRentalRequest.find(params[:id]).cat_id
    else
      id = params[:id]
    end
    @cat = Cat.find(id)
    unless current_user && current_user.id == @cat.user_id
      flash[:errors] = ["This is not your cat."]
      redirect_to cats_url
    end
  end

  def current_user
    return nil if session[:user_id].nil?
    User.find(session[:user_id])
  end

  def log_in!(user)
    session[:user_id] = user.id
  end

  def log_out!(user)
    session[:user_id] = nil
  end

  helper_method :current_user
end

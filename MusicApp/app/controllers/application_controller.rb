class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  helper_method :current_user, :logged_in?, :is_admin?
  
  def current_user
    User.find_by(session_token: session[:session_token])
  end
  
  def log_in_user!(user)
    session[:session_token] = user.reset_session_token!
  end
  
  def logged_in?
    !current_user.nil?
  end
  
  def log_out!(user)
    user.reset_session_token!
    session[:session_token] = nil
  end
  
  def user_logged_in
    redirect_to new_session_url unless logged_in?
  end
  
  def is_admin?
    return false if current_user.nil?
    current_user.is_admin?
  end
end

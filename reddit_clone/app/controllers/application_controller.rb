class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  helper_method :current_user
  
  def log_in!(user)
    user.reset_session_token!
    session[:session_token] = user.session_token
  end
  
  def log_out!(user)
    session[:session_token] = nil
    user.reset_session_token!
  end
  
  def current_user
    return nil unless session[:session_token]
    @current_user ||= User.find_by(session_token: session[:session_token])
  end
  
end

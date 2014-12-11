class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  helper_method :current_user
  
  def current_user
    User.find_by(session_token: session[:session_token])
  end
  
  def login_user!
    session[:session_token] = @user.session_token
    redirect_to user_url
  end
  
  def redirect_logged_users
    redirect_to user_url if current_user
  end
  
  protected
  
  def user_params
    params.require(:user).permit(:user_name, :password)
  end
end
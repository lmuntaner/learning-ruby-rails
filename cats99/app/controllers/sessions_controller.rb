class SessionsController < ApplicationController
  before_action :redirect_logged_users, only: :new
 
  def create
    @user = User.find_by_credentials(params[:user][:user_name], params[:user][:password])
    
    if @user.nil?
      flash[:errors] = "Wrong username / password / website logic"
      render :new
    else
      login_user!
    end
  end
  
  def new
    @user = User.new
    render :new
  end
  
  def destroy
    @user = User.find_by(session_token: session[:session_token])
    @user.reset_session_token!
    session[:session_token] = nil
    redirect_to new_session_url
  end
end

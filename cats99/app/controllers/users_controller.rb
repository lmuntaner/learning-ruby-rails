class UsersController < ApplicationController
  before_action :redirect_logged_users, only: :new
  
  def new
    @user = User.new
    render :new
  end
  
  def create
    @user = User.new(user_params)
    # @user.user_name = params[:user][:user_name]
    # @user.password = params[:user][:password]
    # @user.reset_session_token!
    
    if @user.save
      login_user!
    else
      flash[:errors] = @user.errors.full_messages
      render :new
    end
  end
  
  def show
    @user = current_user
    if @user.nil?
      redirect_to new_session_url
    else
      render :show
    end
  end
end

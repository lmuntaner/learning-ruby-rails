class UsersController < ApplicationController
  
  def new
    @user = User.new
    render :new
  end
  
  def create
    @user = User.new(user_params)
    @user.set_activation_token
    
    if @user.save
      msg = UserMailer.activation_email(@user)
      msg.deliver
    else
      flash[:errors] = @user.errors.full_messages
      render :new
    end
  end
  
  def show
    redirect_to new_session_url if current_user.nil?
    @user = current_user
  end
  
  def activate
    @user = User.find_by(activation_token: params[:activation_token])
    @user.activate!
    log_in_user!(@user)
    redirect_to user_url
  end
  
  private
  
  def user_params
    params[:user].permit(:email, :password)
  end
  
end

class UsersController < ApplicationController
  
  def new
    @user = User.new
    render :new
  end
  
  def index
    @users = User.all
    render :index
  end
  
  def create
    @user = User.new(user_params)
    
    if @user.save
      log_in!(@user)
      redirect_to user_url
    else
      flash[:errors] = @user.errors.full_messages
      render :new
    end
  end
  
  def edit
    render :edit
  end
  
  def update
    @user = current_user
    if @user.update(user_params)
      redirect_to user_url
    else
      flash[:errors] = @user.errors.full_messages
      render :edit
    end  
  end
  
  def show
    @subs = Sub.all
    render :show
  end
  
  def destroy
  end
  
  private
  
  def user_params
    params.require(:user).permit(:username, :password)
  end
  
end

class SubsController < ApplicationController
  
  before_action :set_sub, except: [:index, :new, :create]
  before_action :verify_moderator, only: [:edit, :destroy, :update]
  
  def show
    render :show
  end
  
  def index
    @subs = Sub.all
    render :index
  end
  
  def create
    @sub = current_user.subs.new(sub_params)
    
    if @sub.save
      flash[:notices] = ["Sub was created"]
      redirect_to sub_url(@sub)
    else
      flash[:errors] = @sub.errors.full_messages
      render :new
    end
  end
  
  def new
    @sub = Sub.new
    render :new
  end
  
  def destroy
    @sub.destroy
    redirect_to subs_url
  end
  
  def edit
    render :edit
  end
  
  def update
    if @sub.update(sub_params)
      flash[:notices] = ["The sub was updated"]
      redirect_to sub_url(@sub)
    else
      flash[:errors] = @sub.errors.full_messages
      render :edit
    end
  end
  
  private
  
  def sub_params
    params.require(:sub).permit(:title, :description)
  end
  
  def set_sub
    @sub = Sub.find(params[:id])
  end
  
  def verify_moderator
    redirect_to user_url unless current_user.id == Sub.find(params[:id]).moderator_id
  end
  
end

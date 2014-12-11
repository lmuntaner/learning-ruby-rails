class CatsController < ApplicationController
  
  before_action :only_owner_can_update, only: [:update, :edit]
  
  def index
    @cats = Cat.all
    render :index
  end
  
  def only_owner_can_update
    @cat = Cat.find(params[:id])
    redirect_to new_session_url unless @cat.owner_id == current_user.id
  end
  
  def show
    @cat = Cat.find(params[:id])
    @cat_rental_requests = @cat.rental_requests
    @cat_rental_request = CatRentalRequest.new()
    render :show
  end
  
  def new
    @cat = Cat.new
    render :new
  end
  
  def create
    @cat = current_user.cats.new(cat_params)
    # @cat = Cat.new(cat_params)
    # @cat.owner_id = current_user.id
    
    if @cat.save
      redirect_to cat_url(@cat)
    else
      flash.now[:notice] = @cat.errors.full_messages
      render :new
    end
  end
  
  def edit
    @cat = Cat.find(params[:id])
    render :edit
  end
  
  def update
    @cat = Cat.find(params[:id])
    
    if @cat.update(cat_params)
      redirect_to user_cat_url(@cat)
    else
      flash.now[:notice] = @cat.errors.full_messages
      render :edit
    end
  end
  
  private
  def cat_params
    params[:cat].permit(:sex, :birth_date, :color, :name, :description, :owner_id)
  end
end

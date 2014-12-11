class CatRentalRequestsController < ApplicationController
  
  #before_action :ensure_cat_owner
  
  def create
    @cat_rental_request = CatRentalRequest.new(cat_rental_request_params)
    @cat_rental_request.cat_id = params[:cat_id]
    @cat_rental_request.user_id = current_user.id
    
    if @cat_rental_request.save
      redirect_to user_url
    else
      flash[:notice] = @cat_rental_request.errors.full_messages
      redirect_to cat_url(@cat_rental_request.cat)
    end
  end
  
  def approve
    @cat_rental_request = CatRentalRequest.find(params[:id])
    
    if @cat_rental_request.approve!
      redirect_to cat_url(@cat_rental_request.cat)
    else
      flash[:notice] = ["This request CANNOT be approved"]
      redirect_to cat_url(@cat_rental_request.cat)    
    end
  end
  
  def deny
    @request = CatRentalRequest.find(params[:id])
    @request.deny!
    redirect_to cat_url(@request.cat)
  end
  
  private
  def cat_rental_request_params
    params[:cat_rental_request].permit(:cat_id, :start_date, :end_date)
  end
end

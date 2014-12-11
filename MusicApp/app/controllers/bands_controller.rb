class BandsController < ApplicationController
  before_action :user_logged_in
  before_action :is_admin, except: [:index, :show]
  
  def index
    @bands = Band.all
    render :index
  end
  
  def show
    @band = band_by_id
    render :show
  end
  
  def new
    @band = Band.new
    render :new
  end
  
  def create
    @band = Band.new(band_params)
    
    if @band.save
      redirect_to band_url(@band)
    else
      flash[:errors] = @band.errors.full_messages
      render :new
    end
  end
  
  def edit
    @band = band_by_id
    render :edit
  end
  
  def update
    @band = band_by_id
    
    if @band.update(band_params)
      redirect_to band_url(@band)
    else
      flash[:errors] = @band.errors.full_messages
      render :edit
    end
  end
  
  def destroy
    @band = band_by_id
    flash[:errors] = "You deleted #{@band.name} successfully!"
    @band.destroy
    redirect_to new_band_url
  end
  
  private
  def band_params
    params.require(:band).permit(:name)
  end
  
  def band_by_id
    Band.find(params[:id])
  end
  
  def user_logged_in
    redirect_to new_session_url unless logged_in?
  end
end

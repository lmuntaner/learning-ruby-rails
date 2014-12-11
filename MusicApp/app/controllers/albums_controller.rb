class AlbumsController < ApplicationController
  before_action :user_logged_in
  before_action :set_album, only: [:show, :edit, :update, :destroy]
  before_action :is_admin, except: [:index, :show]
  
  def show
    # @album = album_by_id
    render :show
  end
  
  def new
    @album = Album.new
    @bands = Band.all
    render :new
  end
  
  def create
    @album = Album.new(album_params)
    @bands = Band.all
    
    if @album.save
      redirect_to album_url(@album)
    else
      flash[:errors] = @album.errors.full_messages
      render :new
    end
  end
  
  def edit
    # @album = album_by_id
    @bands = Band.all
    render :edit
  end
  
  def update
    # @album = album_by_id
    @bands = Band.all
    
    if @album.update(album_params)
      redirect_to album_url(@album)
    else
      flash[:errors] = @album.errors.full_messages
      render :edit
    end
  end
  
  def destroy
    # @album = album_by_id
    flash[:errors] = "You deleted #{@album.name} successfully!"
    @album.destroy
    redirect_to new_album_url
  end
  
  private
  
  def album_params
    params.require(:album).permit(:name, :recorded_at, :band_id)
  end
  
  def set_album
    @album = Album.find(params[:id])
  end
end

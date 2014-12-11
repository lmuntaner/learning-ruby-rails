class TracksController < ApplicationController
  before_action :user_logged_in
  before_action :is_admin, except: [:index, :show]
  
  def show
    @track = track_by_id
    render :show
  end
  
  def new
    @track = Track.new
    @albums = Album.all
    render :new
  end
  
  def create
    @track = Track.new(track_params)
    @albums = Album.all
    
    if @track.save
      redirect_to track_url(@track)
    else
      flash[:errors] = @track.errors.full_messages
      render :new
    end
  end
  
  def edit
    @track = track_by_id
    @albums = Album.all
    render :edit
  end
  
  def update
    @track = track_by_id
    @albums = Album.all
    
    if @track.update(track_params)
      redirect_to track_url(@track)
    else
      flash[:errors] = @track.errors.full_messages
      render :edit
    end
  end
  
  def destroy
    @track = track_by_id
    flash[:errors] = "You deleted #{@track.name} successfully!"
    @track.destroy
    redirect_to new_track_url
  end
  
  private
  def track_params
    params.require(:track).permit(:name, :bonus, :lyrics, :album_id)
  end
  
  def track_by_id
    Track.find(params[:id])
  end
end

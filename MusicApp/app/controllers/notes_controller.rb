class NotesController < ApplicationController
  before_action :user_logged_in
  
  def create
    @note = Note.new(note_params)
    @note.track_id = params[:track_id]
    @note.user_id = current_user.id 
    
    # @note = current_user.notes.new(note_params)
    
    if @note.save
      redirect_to track_url(@note.track)
    else
      flash[:errors] = @note.errors.full_messages
      redirect_to track_url(@note.track)
    end
  end
  
  def destroy
    @note = Note.find(params[:id])
    @track = @note.track
    redirect_to track_url(@track) unless (current_user = @note.user || is_admin?)
    flash[:notes] = "Note deleted succesfully"
    @note.destroy
    redirect_to track_url(@track)
  end
  
  private
  def note_params
    params.require(:note).permit(:text)#.merge { track_id: params[:track_id] }
  end
end

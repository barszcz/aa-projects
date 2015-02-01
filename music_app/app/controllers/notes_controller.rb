class NotesController < ApplicationController
  def create
    @note = Note.new(note_params)
    @note.user_id = current_user.id
    unless @note.save
      flash[:errors] = @note.errors.full_messages
    end
      redirect_to track_url(@note.track_id)
  end

  def destroy
    @note = Note.find(params[:id])
    @note.destroy
    unless current_user.id == @note.user_id
      render text: "403 error, ya dingus"
    end
    redirect_to track_url(@note.track_id)
  end

  private

  def note_params
    params.require(:note).permit([:body, :track_id])
  end
end

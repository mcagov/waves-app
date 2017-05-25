class Submission::NotesController < InternalPagesController
  before_action :load_submission

  def create
    @note = Note.new(note_params)
    @note.actioned_by = current_user
    @note.noteable = @submission
    @note.save

    @modal_id = "note-content-add"
    respond_to do |format|
      format.js { render :update }
    end
  end

  def update
    @note = Note.find(params[:id])
    @note.actioned_by = current_user
    @note.content = note_params[:content]
    @note.save

    @modal_id = "edit-note-#{@note.id}"
    respond_to do |format|
      format.js
    end
  end

  private

  def note_params
    params.require(:note).permit(:content)
  end
end

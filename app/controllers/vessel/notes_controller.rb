class Vessel::NotesController < InternalPagesController
  before_action :load_vessel

  def create
    @note = Note.new(note_params)
    @note.actioned_by = current_user
    @note.noteable = @vessel

    flash[:notice] = "The note has been saved" if @note.save

    redirect_to vessel_path(@vessel)
  end

  private

  def load_vessel
    @vessel = Register::Vessel.find(params[:vessel_id])
  end

  def note_params
    params.require(:note).permit(:content, assets_attributes: [:file])
  end
end

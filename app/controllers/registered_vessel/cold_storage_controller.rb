class RegisteredVessel::ColdStorageController < InternalPagesController
  before_action :load_vessel

  def create
    @note = Note.new(note_params)
    @note.actioned_by = current_user
    @note.noteable = @vessel
    @note.save

    if @vessel.registration_status == :frozen
      @vessel.update_attribute(:frozen_at, nil)
    else
      @vessel.update_attribute(:frozen_at, Time.now)
    end

    redirect_to vessel_path(@vessel)
  end

  private

  def note_params
    params.require(:note).permit(:content)
  end
end

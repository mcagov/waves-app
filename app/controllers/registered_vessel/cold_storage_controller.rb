class RegisteredVessel::ColdStorageController < InternalPagesController
  before_action :load_vessel

  def create
    @note = Note.new(note_params)
    @note.actioned_by = current_user
    @note.noteable = @vessel
    @note.save

    toggle_frozen_state
    redirect_to vessel_path(@vessel)
  end

  private

  def note_params
    params.require(:note).permit(:content)
  end

  def toggle_frozen_state
    if @vessel.registration_status == :frozen
      @vessel.restore_active_state! if @vessel.can_restore_active_state?
      @vessel.update_attribute(:frozen_at, nil)
    else
      @vessel.update_attribute(:frozen_at, Time.now)
    end
  end
end

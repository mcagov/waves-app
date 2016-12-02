class Vessel::ClosureController < InternalPagesController
  before_action :load_vessel

  def create
    if @vessel.registration_status != :closed
      complete_closure_submission
      log_work!(@submission, @submission, :registrar_closure)
    else
      complete_restore_closure_submission
      log_work!(@submission, @submission, :registrar_restores_closure)
    end

    redirect_to vessel_path(@vessel)
  end

  private

  def load_vessel
    @vessel =
      Register::Vessel
      .in_part(current_activity.part).find(params[:vessel_id])
  end

  def complete_closure_submission
    @submission = Submission.create(
      task: :registrar_closure,
      part: current_activity.part,
      vessel_reg_no: @vessel.reg_no,
      source: :manual_entry,
      state: :completed,
      ref_no: RefNo.generate_for(Submission.new),
      claimant: current_user,
      received_at: Time.now,
      registry_info: @vessel.registry_info,
      changeset: @vessel.registry_info)

    Builders::ClosedRegistrationBuilder
      .create(@submission, Time.now, Task.new(:registrar_closure).description)
  end

  def complete_restore_closure_submission
     @submission = Submission.create(
      task: :registrar_restores_closure,
      part: current_activity.part,
      vessel_reg_no: @vessel.reg_no,
      source: :manual_entry,
      state: :completed,
      ref_no: RefNo.generate_for(Submission.new),
      claimant: current_user,
      received_at: Time.now,
      registry_info: @vessel.registry_info,
      changeset: @vessel.registry_info)

    Builders::RestoreClosedRegistrationBuilder.create(@submission)
  end
end

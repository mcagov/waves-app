class RegisteredVessel::ManualOverrideController < InternalPagesController
  before_action :load_vessel

  def create
    create_manual_override_submission
    log_work!(@submission, @submission, :manual_override)

    redirect_to submission_path(@submission)
  end

  private

  def load_vessel
    @vessel =
      Register::Vessel
      .in_part(current_activity.part).find(params[:vessel_id])
  end

  def create_manual_override_submission
    @submission =
      Builders::AssignedSubmissionBuilder.create(
        :manual_override,
        current_activity.part,
        @vessel,
        current_user)
  end
end

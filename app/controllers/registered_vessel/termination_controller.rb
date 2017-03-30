class RegisteredVessel::TerminationController < InternalPagesController
  before_action :load_vessel

  def create
    complete_termination_submission
    log_work!(@submission, @submission, :termination_notice)

    redirect_to submission_approval_path(@submission)
  end

  private

  def load_vessel
    @vessel =
      Register::Vessel
      .in_part(current_activity.part).find(params[:vessel_id])
  end

  def complete_termination_submission
    @submission =
      Builders::CompletedSubmissionBuilder.create(
        :termination_notice,
        current_activity.part,
        @vessel,
        current_user)
  end
end

class RegisteredVessel::TerminationController < InternalPagesController
  before_action :load_vessel

  def create
    complete_termination_notice_submission
    log_work!(@submission, @submission, :termination_notice)

    redirect_to submission_approval_path(@submission)
  end

  private

  def load_vessel
    @vessel =
      Register::Vessel
      .in_part(current_activity.part).find(params[:vessel_id])
  end

  def complete_termination_notice_submission
    @submission =
      Builders::CompletedSubmissionBuilder.create(
        :termination_notice,
        current_activity.part,
        @vessel,
        current_user)

    @vessel.update_attribute(:frozen_at, Time.now)

    @vessel.current_registration.update_attribute(
      :termination_notice_at, Time.now)
  end
end

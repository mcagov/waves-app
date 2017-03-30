class RegisteredVessel::TerminationController < InternalPagesController
  before_action :load_vessel

  def create
    build_completed_submission
    process_termination_submission

    log_work!(@submission, @submission, :termination_notice)

    redirect_to submission_approval_path(@submission)
  end

  private

  def load_vessel
    @vessel =
      Register::Vessel
      .in_part(current_activity.part).find(params[:vessel_id])
  end

  def build_completed_submission
    @submission =
      Builders::CompletedSubmissionBuilder.create(
        :termination_notice,
        current_activity.part,
        @vessel,
        current_user)
  end

  def process_termination_submission
    @vessel.update_attribute(:frozen_at, Time.now)

    @vessel.current_registration.update_attribute(
      :termination_notice_at, Time.now)

    Task.new(:termination_notice).print_job_templates.each do |template|
      PrintJob.create(
        printable: @vessel.current_registration,
        part: @submission.part,
        template: template,
        submission: @submission)
    end
  end
end

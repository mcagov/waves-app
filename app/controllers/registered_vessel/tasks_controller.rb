class RegisteredVessel::TasksController < InternalPagesController
  before_action :load_vessel
  before_action :load_submission

  def create
    @task = Submission::Task.create(
      submission: @submission,
      service_id: params[:service_id],
      claimant: current_user)

    @task.confirm!
    @task.claim!(current_user)

    log_work!(@task, @task, :manual_override)

    redirect_to submission_task_path(@submission, @task)
  end

  private

  def load_submission
    @submission = @vessel.current_submission
    @submission ||= Submission.create(
      vessel_reg_no: @vessel.reg_no,
      part: @vessel.part,
      source: :manual_entry,
      application_type: :manual_override,
      received_at: Time.zone.today)
  end
end

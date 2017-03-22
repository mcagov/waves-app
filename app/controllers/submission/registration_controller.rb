class Submission::RegistrationController < InternalPagesController
  def show
    @submission = Submission.find(params[:submission_id])
    @registered_vessel = @submission.registered_vessel
    @print_jobs = PrintJob.where(submission: @submission)
  end
end

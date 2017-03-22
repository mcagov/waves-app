class Submission::RegistrationController < InternalPagesController
  def show
    @submission = Submission.find(params[:submission_id])
    @registration = @submission.registration
    @registered_vessel = @registration.registered_vessel
    @print_jobs = PrintJob.where(printable: @registration)
  end
end

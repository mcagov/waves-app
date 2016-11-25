class RegistrationsController < InternalPagesController
  def show
    @registration = Registration.find(params[:id])
    @submission = Submission.find_by(ref_no: @registration.submission_ref_no)
  end
end

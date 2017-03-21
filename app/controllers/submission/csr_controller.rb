class Submission::CsrController < InternalPagesController
  before_action :load_submission

  def show
    @csr = CsrForm.for(@submission)
  end

  protected

  def load_submission
    @submission =
      Submission.in_part(current_activity.part).find(params[:submission_id])
  end
end

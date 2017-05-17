class Submission::ApplicantsController < InternalPagesController
  before_action :load_submission

  def update
    @submission.assign_attributes(submission_params)
    @submission.save

    @submission = Decorators::Submission.new(@submission)

    respond_to do |format|
      format.js { render "/submissions/basic/forms/applicant/update" }
    end
  end

  protected

  def submission_params
    params.require(:submission).permit(:applicant_name, :applicant_email)
  end
end

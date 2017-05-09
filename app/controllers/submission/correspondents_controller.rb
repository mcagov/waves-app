class Submission::CorrespondentsController < InternalPagesController
  before_action :load_submission

  def update
    @submission.assign_attributes(submission_params)
    @submission.applicant_name = @submission.correspondent.name
    @submission.applicant_email = @submission.correspondent.email
    @submission.save

    @modal_id = params[:modal_id]

    respond_to do |format|
      format.js { render "/submissions/extended/forms/correspondent/update" }
    end
  end

  protected

  def submission_params
    params.require(:submission).permit(:correspondent_id)
  end
end

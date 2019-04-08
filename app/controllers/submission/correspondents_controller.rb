class Submission::CorrespondentsController < InternalPagesController
  before_action :load_submission

  def update
    @submission =
      Builders::CorrespondentBuilder.create(
        @submission, submission_params[:correspondent_id])

    @modal_id = params[:modal_id]
    @submission = Decorators::Submission.new(@submission)

    respond_to do |format|
      format.js { render "/submissions/extended/forms/correspondent/update" }
    end
  end

  protected

  def submission_params
    params.require(:submission).permit(:correspondent_id)
  end
end

class Submission::CorrespondentsController < InternalPagesController
  before_action :load_submission

  def update
    @submission.update_attributes(submission_params)
    @modal_id = params[:modal_id]

    respond_to do |format|
      format.js { render "/submissions/extended/forms/correspondent/update" }
    end
  end

  protected

  def load_submission
    @submission =
      Submission.in_part(current_activity.part)
                .includes(:declarations).find(params[:submission_id])
  end

  def submission_params
    params.require(:submission).permit(:correspondent_id)
  end
end

class Submission::ShareholdingsController < InternalPagesController
  before_action :load_submission

  def show
    respond_to do |format|
      format.js
    end
  end

  protected

  def load_submission
    @submission =
      Submission.in_part(current_activity.part)
                .includes(:declarations).find(params[:submission_id])
  end
end

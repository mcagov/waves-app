class Submission::ManagingOwnersController < InternalPagesController
  before_action :load_submission

  def update
    @submission.update_attributes(submission_params)

    @modal_id = params[:modal_id]
    @submission = Decorators::Submission.new(@submission)

    respond_to do |format|
      format.js { render "/submissions/extended/forms/correspondent/update" }
    end
  end

  protected

  def submission_params
    params.require(:submission).permit(:managing_owner_id)
  end
end

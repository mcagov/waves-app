class SubmissionDetailsController < InternalPagesController
  before_action :load_submission, except: [:show]

  def edit; end

  def update
    if @submission.update_attributes(submission_details_params)

      flash[:notice] = "The application has been updated"
      redirect_to submission_path(@submission)
    else
      render :edit
    end
  end

  protected

  def load_submission
    @submission = Submission.find(params[:submission_id])
  end

  def submission_details_params
    params.require(:submission).permit(
      :part, :task, vessel: [:reg_no]
    )
  end
end

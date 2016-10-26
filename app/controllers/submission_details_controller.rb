class SubmissionDetailsController < InternalPagesController
  before_action :load_submission, except: [:show]

  def edit; end

  def update
    @original_submission_part = @submission.part
    if @submission.update_attributes(submission_details_params)
      succcessful_redirect
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
      :part, :task, :vessel_reg_no
    )
  end

  def succcessful_redirect
    if @original_submission_part == @submission.part
      flash[:notice] = "The application has been updated"
      redirect_to submission_path(@submission)
    else
      @submission.unclaimed!
      flash[:notice] = "The application has been moved\
                       to #{Activity.new(@submission.part)}"
      redirect_to tasks_my_tasks_path
    end
  end
end

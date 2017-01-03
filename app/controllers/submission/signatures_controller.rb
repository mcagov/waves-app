class Submission::SignaturesController < InternalPagesController
  before_action :load_submission

  def show
  end

  def update
    @submission.assign_attributes(submission_params)

    if @submission.save
      redirect_to submission_path(@submission)
    else
      render :show
    end
  end

  protected

  def load_submission
    @submission = Submission.find(params[:submission_id])
  end

  def submission_params
    params.require(:submission).permit(:task, :vessel_reg_no)
  end
end

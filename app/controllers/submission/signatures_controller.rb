class Submission::SignaturesController < InternalPagesController
  before_action :load_submission

  def show
  end

  def update
    @submission.assign_attributes(submission_params)
    @submission.registry_info = nil

    if @submission.save
      successful_redirect
    else
      render :show
    end
  end

  protected

  def load_submission
    @submission = Submission.find(params[:submission_id])
  end

  def submission_params
    params.require(:submission).permit(:part, :task, :vessel_reg_no)
  end

  def successful_redirect
    if @submission.part.to_sym == current_activity.part
      redirect_to submission_path(@submission)
    else
      render :part_changed
    end
  end
end

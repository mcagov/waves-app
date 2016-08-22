class SubmissionsController < InternalPagesController
  before_action :load_submission

  def show
  end

  def claim
    @submission.update_attribute(:claimant, current_user)
    @submission.claimed!

    flash[:notice] = "You have succesfully claimed this application"
    redirect_to submission_path(@submission)
  end


  def unclaim
    @submission.update_attribute(:claimant, nil)
    @submission.unclaimed!

    flash[:alert] = "That application has been moved into the Unclaimed Tasks queue"
    redirect_to tasks_my_tasks_path
  end

  def approve
    @submission.complete!
    render "completed"
  end

  protected

  def load_submission
    @submission = Submission.find(params[:id])
  end
end

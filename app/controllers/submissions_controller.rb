class SubmissionsController < InternalPagesController
  before_action :load_submission

  def show
  end

  def claim
    @submission.update_attribute(:claimant, current_user)
    @submission.claimed!(current_user)

    flash[:notice] = "You have succesfully claimed this application"
    redirect_to tasks_my_tasks_path
  end


  def unclaim
    @submission.unclaimed!

    flash[:notice] = "That application has been moved into the Unclaimed Tasks queue"
    redirect_to tasks_my_tasks_path
  end

  def approve
    if @submission.process_application
      @submission.approved!
      render "completed"
    else
      render "errors"
    end
  end

  protected

  def load_submission
    @submission = Submission.find(params[:id])
  end
end

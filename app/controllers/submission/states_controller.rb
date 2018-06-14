class Submission::StatesController < InternalPagesController
  before_action :load_submission

  def claim
    @submission.claimed!(current_user)

    respond_to do |format|
      format.html do
        flash[:notice] = "You have successfully claimed this application"
        redirect_to submission_path(@submission)
      end
      format.js { render "tasks/actions/claim_button" }
    end
  end

  def unclaim
    @submission.unclaimed!

    respond_to do |format|
      format.html do
        flash[:notice] = "Application has been moved into Unclaimed DeprecableTasks"
        redirect_to tasks_my_tasks_path
      end
      format.js { render "tasks/actions/claim_button" }
    end
  end

  def claim_referral
    @submission.unreferred!
    @submission.claimed!(current_user)

    log_work!(@submission, @submission, :referral_reclaimed)
    flash[:notice] = "You have successfully claimed this application"
    redirect_to tasks_my_tasks_path
  end
end

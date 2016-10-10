class SubmissionsController < InternalPagesController
  before_action :load_submission, except: [:show]

  def show
    @submission = Submission.includes(
      [:payment, :correspondences, :notifications]).find(params[:id])
  end

  def claim
    @submission.claimed!(current_user)

    respond_to do |format|
      format.html do
        flash[:notice] = "You have succesfully claimed this application"
        redirect_to submission_path(@submission)
      end
      format.js { render "tasks/actions/claim_button" }
    end
  end

  def unclaim
    @submission.unclaimed!

    respond_to do |format|
      format.html do
        flash[:notice] = "Application has been moved into Unclaimed Tasks"
        redirect_to tasks_my_tasks_path
      end
      format.js { render "tasks/actions/claim_button" }
    end
  end

  def claim_referral
    @submission.unreferred!
    @submission.claimed!(current_user)

    flash[:notice] = "You have succesfully claimed this application"
    redirect_to tasks_my_tasks_path
  end

  def approve
    if @submission.approved!
      create_notification
      render "approved"
    else
      render "errors"
    end
  end

  protected

  def load_submission
    @submission = Submission.find(params[:id])
  end

  def create_notification
    @submission.owners.each do |owner|
      Notification::ApplicationApproval.create(
        recipient_email: owner.email,
        recipient_name: owner.name,
        notifiable: @submission,
        subject: @submission.job_type,
        actioned_by: current_user,
        attachments: params[:notification_attachments])
    end
  end
end

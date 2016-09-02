class NotificationsController < InternalPagesController
  before_action :load_submission

  def cancel
    Notification::Cancellation.create(
      submission_id: @submission.id,
      subject: notification_params[:subject],
      body: notification_params[:body],
      actioned_by: current_user
    )

    flash[:notice] = "You have succesfully cancelled that application"
    @submission.cancelled!
    redirect_to tasks_my_tasks_path
  end

  def reject
    Notification::Rejection.create(
      submission_id: @submission.id,
      subject: notification_params[:subject],
      body: notification_params[:body],
      actioned_by: current_user
    )

    flash[:notice] = "You have succesfully rejected that application"
    @submission.rejected!
    redirect_to tasks_my_tasks_path
  end

  def refer
    Notification::Referral.create(
      submission_id: @submission.id,
      subject: notification_params[:subject],
      body: notification_params[:body],
      actioned_by: current_user
    )

    flash[:notice] = "You have succesfully referred that application"
    @submission.update_attribute(:referred_until, notification_params[:due_by])

    @submission.referred!
    redirect_to tasks_my_tasks_path
  end

  private

  def load_submission
    @submission = Submission.find(params[:id])
  end

  def notification_params
    params.require(:notification).permit(:subject, :body, :due_by)
  end
end

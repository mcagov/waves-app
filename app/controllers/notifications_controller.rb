class NotificationsController < InternalPagesController
  before_action :load_submission

  def cancel
    Notification::Cancellation.create(
      parsed_notification_params(@submission.correspondent))

    flash[:notice] = "You have succesfully cancelled that application"
    @submission.cancelled!
    redirect_to tasks_my_tasks_path
  end

  def reject
    Notification::Rejection.create(
      parsed_notification_params(@submission.correspondent))

    flash[:notice] = "You have succesfully rejected that application"
    @submission.rejected!
    redirect_to tasks_my_tasks_path
  end

  def refer
    Notification::Referral.create(
      parsed_notification_params(@submission.correspondent))

    flash[:notice] = "You have succesfully referred that application"
    @submission.update_attribute(
      :referred_until, notification_params[:actionable_at])

    @submission.referred!
    redirect_to tasks_my_tasks_path
  end

  private

  def load_submission
    @submission = Submission.find(params[:id])
  end

  def notification_params
    params.require(:notification).permit(:subject, :body, :actionable_at)
  end

  def parsed_notification_params(owner)
    {
      notifiable: @submission,
      subject: notification_params[:subject],
      body: notification_params[:body],
      actioned_by: current_user,
      recipient_email: owner.email,
      recipient_name: owner.name,
    }
  end
end

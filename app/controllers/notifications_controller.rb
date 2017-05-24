class NotificationsController < InternalPagesController
  before_action :load_submission

  def cancel
    Notification::Cancellation.create(parsed_notification_params)

    flash[:notice] = "You have successfully cancelled that application"
    @submission.cancelled!

    log_work!(@submission, @submission, :cancellation)
    redirect_to tasks_my_tasks_path
  end

  def refer
    if params[:send_email].present?
      Notification::Referral.create(parsed_notification_params)
    end

    flash[:notice] = "You have successfully referred that application"
    @submission.update_attribute(
      :referred_until, notification_params[:actionable_at])

    @submission.referred!

    log_work!(@submission, @submission, :referred)
    redirect_to tasks_my_tasks_path
  end

  private

  def load_submission
    @submission = Submission.find(params[:id])
  end

  def notification_params
    params.require(:notification).permit(:subject, :body, :actionable_at)
  end

  def parsed_notification_params
    {
      notifiable: @submission,
      subject: notification_params[:subject],
      body: notification_params[:body],
      actioned_by: current_user,
      recipient_email: @submission.applicant_email,
      recipient_name: @submission.applicant_name,
    }
  end
end

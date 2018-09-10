class Submission::Task::NotificationsController < InternalPagesController
  before_action :load_submission
  before_action :load_task

  def show
    @submission = Decorators::Submission.new(@submission)
    case params[:template]
    when "refer"
      render :refer
    when "cancel"
      render :cancel
    end
  end

  def cancel
    @task.cancel!

    process_cancellation_notification if notification_params[:recipients]
    log_work!(@task, @submission, :task_cancelled)
    StaffPerformanceLog.record(@task, :cancelled, current_user)
     flash[:notice] = "You have successfully cancelled that task"

    redirect_to tasks_my_tasks_path
  end

  def refer
    @task.update_attribute(
      :referred_until, notification_params[:actionable_at])
    @task.refer!

    process_referral_notification if notification_params[:recipients]
    log_work!(@task, @submission, :task_referred)
    StaffPerformanceLog.record(@task, :referred, current_user)
    flash[:notice] = "You have successfully referred that task"

    redirect_to tasks_my_tasks_path
  end

  private

  def load_submission
    @submission = Submission.find(params[:submission_id])
  end

  def notification_params
    params.require(:notification).permit(
      :subject, :body, :actionable_at, recipients: [])
  end

  def parsed_notification_params(recipient)
    {
      notifiable: @submission,
      subject: notification_params[:subject],
      body: notification_params[:body],
      actioned_by: current_user,
      recipient_email: recipient.email,
      recipient_name: recipient.name,
    }
  end

  def process_cancellation_notification
    notification_params[:recipients].each do |recipient|
      Notification::Cancellation.create(
        parsed_notification_params(Customer.new(email_description: recipient)))
    end
  end

  def process_referral_notification
    notification_params[:recipients].each do |recipient|
      Notification::Referral.create(
        parsed_notification_params(Customer.new(email_description: recipient)))
    end
  end
end

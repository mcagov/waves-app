class NotificationsController < InternalPagesController
  before_action :load_submission

  def reject
    Notification::Rejection.create(
      submission_id: @submission.id,
      subject: notification_params[:subject],
      body: notification_params[:body]
      )

    @submission.rejected!
    redirect_to tasks_my_tasks_path
  end

  private

  def load_submission
    @submission = Submission.find(params[:id])
  end

  def notification_params
    params.require(:notification).permit(:subject, :body)
  end
end

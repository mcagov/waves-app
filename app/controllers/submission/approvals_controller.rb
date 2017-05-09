class Submission::ApprovalsController < InternalPagesController
  before_action :load_submission

  def create
    if @submission.approved!(approval_params.to_h)
      build_notification
      log_work!(@submission, @submission, :processed_application)
      redirect_to submission_approval_path(@submission)
    else
      render "errors"
    end
  end

  def show; end

  protected

  def approval_params
    return {} unless params[:submission_approval]

    params.require(:submission_approval).permit(
      :notification_attachments,
      :registration_starts_at,
      :closure_at,
      :closure_reason)
  end

  def build_notification
    Builders::NotificationBuilder
      .application_approval(
        @submission,
        current_user,
        approval_params[:notification_attachments])
  end
end

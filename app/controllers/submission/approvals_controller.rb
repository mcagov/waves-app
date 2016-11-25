class Submission::ApprovalsController < InternalPagesController
  before_action :load_submission

  def create
    if @submission.approved!(approval_params)
      build_notification

      redirect_to registration_path(
        Registration.find_by(submission_ref_no: @submission.ref_no))
    else
      render "errors"
    end
  end

  protected

  def load_submission
    @submission =
      Submission.in_part(current_activity.part).find(params[:submission_id])
  end

  def approval_params
    return {} unless params[:submission_approval]

    params.require(:submission_approval).permit(
      :notification_attachments,
      :registration_starts_at)
  end

  def build_notification
    Builders::NotificationBuilder
      .application_approval(
        @submission,
        current_user,
        approval_params[:notification_attachments])
  end
end

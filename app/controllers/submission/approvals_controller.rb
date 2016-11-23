class Submission::ApprovalsController < InternalPagesController
  before_action :load_submission

  def create
    if process_approval
      Builders::NotificationBuilder
        .application_approval(
          @submission, current_user, approval_params[:notification_attachments])

      @submission = Decorators::Submission.new(@submission)
      render "approved"
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
    params.require(:submission_approval).permit(
      :notification_attachments,
      :registration_starts_at)
  end

  def registration_starts_at
    approval_params[:registration_starts_at]
  end

  def process_approval
    if @submission.printing_required?
      @submission.move_to_print_queue!(registration_starts_at)
    else
      @submission.skip_print_queue!(registration_starts_at)
    end
  end
end

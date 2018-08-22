class Submission::ApplicationApprovalsController < InternalPagesController
  before_action :load_submission
  before_action :load_task

  def create
    flash[:notice] = "Emails have been sent to the selected recipients"
    # Notification::ApplicationApproval.create(
    #   recipient_email: submission.applicant_email,
    #   recipient_name: submission.applicant_name,
    #   notifiable: submission,
    #   subject: submission.job_type,
    #   actioned_by: actioned_by,
    #   attachments: attachments)

    redirect_to submission_task_path(@submission, @task)
  end
end

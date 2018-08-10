module InitNewSubmission
  include ActiveSupport::Concern

  def send_application_receipt_email
    return unless params[:new_submission_actions] == "application_receipt"

    Notification::ApplicationReceipt.create(
      notifiable: @submission,
      recipient_name: @submission.applicant_name,
      recipient_email: @submission.applicant_email,
      actioned_by: current_user)

    flash[:notice] =
      "An Application Receipt has been sent to #{@submission.applicant_email}"
  end

  def init_new_submission
    @submission = Submission.new(submission_params)
    @submission.source = :manual_entry

    unless Policies::Actions.registered_vessel_required?(@submission)
      @submission.vessel_reg_no = nil
    end
  end
end

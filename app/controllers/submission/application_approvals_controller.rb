class Submission::ApplicationApprovalsController < InternalPagesController
  before_action :load_submission

  def new
    @application_approval =
      Notification::ApplicationApproval.new(
        notifiable_id: @submission.id, notifiable_type: "Submission")

    respond_to do |format|
      format.js
    end
  end

  def create
    if recipients
      recipients.each do |recipient|
        build_notification(Customer.new(email_description: recipient))
      end
      flash[:notice] = "Emails have been sent to the selected recipients"
    else
      flash[:notice] = "No emails were sent. A recipient must be selected."
    end
    redirect_to submission_path(@submission)
  end

  private

  def notification_application_approval_params
    params.require(:notification_application_approval).permit(
      :subject, :body, attachments: [], recipients: [])
  end

  def build_notification(recipient)
    return unless recipient.name && recipient.email
    Notification::ApplicationApproval.create(
      recipient_email: recipient.email,
      recipient_name: recipient.name,
      notifiable: @submission,
      subject: notification_application_approval_params[:subject],
      body: notification_application_approval_params[:body],
      actioned_by: current_user,
      attachments: notification_application_approval_params[:attachments])
  end

  def recipients
    @recipients ||= notification_application_approval_params[:recipients]
  end
end

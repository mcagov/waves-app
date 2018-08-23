class Submission::ApplicationApprovalsController < InternalPagesController
  before_action :load_submission

  def create
    notification_application_approval_params[:recipients].each do |recipient|
      build_notification(Customer.new(email_description: recipient))
    end

    flash[:notice] = "Emails have been sent to the selected recipients"
    redirect_to submission_path(@submission)
  end

  private

  def notification_application_approval_params
    params.require(:notification_application_approval).permit(
      :subject, :body, recipients: [])
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
      attachments: nil)
  end
end

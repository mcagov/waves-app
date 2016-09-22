class Notification::ApplicationApproval < Notification
  def email_template
    :application_approval
  end

  def email_subject
    "Application Approved"
  end
end

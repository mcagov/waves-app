class Notification::ApplicationApproval < Notification
  def email_template
    :application_approval
  end

  def email_subject
    "Application Approved"
  end

  def additional_params
    vessel_reg_no
  end

  private

  def vessel_reg_no
    notifiable.registration.vessel.reg_no
  end
end

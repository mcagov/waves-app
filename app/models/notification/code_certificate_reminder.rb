class Notification::CodeCertificateReminder < Notification
  def email_template
    :code_certificate_reminder
  end

  def additional_params
    [vessel_name, vessel_reg_no]
  end

  def email_subject
    "CODING EXPIRY"
  end

  private

  def vessel
    notifiable
  end

  def vessel_name
    vessel.name if vessel
  end

  def vessel_reg_no
    vessel.reg_no if vessel
  end
end

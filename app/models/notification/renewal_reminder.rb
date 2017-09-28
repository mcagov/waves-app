class Notification::RenewalReminder < Notification
  def email_template
    :renewal_reminder
  end

  def additional_params
    [vessel_name, vessel_reg_no]
  end

  def email_subject
    "Registration Renewal Reminder: #{vessel_name}"
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

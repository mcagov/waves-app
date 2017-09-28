class Notification::RenewalReminder < Notification
  def email_template
    :renewal_reminder
  end

  def additional_params
    [vessel_name, registered_until]
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

  def registered_until
    vessel.registered_until if vessel
  end
end

class Notification::CarvingAndMarkingReminder < Notification
  def email_template
    :carving_and_marking_reminder
  end

  def additional_params
    []
  end

  def email_subject
    "Carving & Marking Reminder: #{vessel_name}"
  end

  private

  def vessel_name
    notifiable.vessel_name if notifiable
  end
end

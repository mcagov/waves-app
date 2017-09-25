class Notification::CarvingAndMarkingReminder < Notification
  def email_template
    :carving_and_marking_reminder
  end

  def additional_params
    [vessel_name, vessel_reg_no]
  end

  def email_subject
    "Carving & Marking Reminder: #{vessel_name}"
  end

  private

  def submission
    notifiable
  end

  def vessel_name
    submission.vessel_name if submission
  end

  def vessel_reg_no
    submission.vessel_reg_no if submission
  end
end

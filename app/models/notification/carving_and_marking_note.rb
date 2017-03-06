class Notification::CarvingAndMarkingNote < Notification
  def email_template
    :wysiwyg
  end

  def additional_params
    [actioned_by]
  end

  def email_subject
    "Carving & Marking note: #{vessel_name}"
  end

  private

  def vessel_name
    notifiable.vessel_name if notifiable
  end
end

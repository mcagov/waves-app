class Notification::CarvingAndMarkingNote < Notification
  def email_template
    :wysiwyg
  end

  def additional_params
    [body, actioned_by]
  end

  def email_subject
    subject
  end

  private

  def vessel_name
    notifiable.vessel_name if notifiable
  end
end

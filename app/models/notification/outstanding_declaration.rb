class Notification::OutstandingDeclaration < Notification
  def email_template
    :outstanding_declaration
  end

  def additional_params
    [notifiable.id, vessel_name, correspondent_name]
  end

  def email_subject
    "Vessel Registration Owner Declaration Required"
  end

  private

  def vessel_name
    notifiable.submission.vessel.to_s  if notifiable.submission
  end

  def correspondent_name
    notifiable.submission.correspondent.to_s if notifiable.submission
  end
end

class Notification::OutstandingDeclaration < Notification
  def email_template
    :outstanding_declaration
  end

  def additional_params
    [notifiable.id, vessel_name]
  end

  def email_subject
    "Vessel Registration Owner Declaration Required"
  end

  private

  def vessel_name
    notifiable.submission.vessel  if notifiable.submission
  end

  def applicant_name
    notifiable.applicant_name if notifiable
  end
end

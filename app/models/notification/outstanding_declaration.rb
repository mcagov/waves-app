class Notification::OutstandingDeclaration < Notification
  def email_template
    :outstanding_declaration
  end

  def additional_params
    notifiable.id
  end

  def email_subject
    "Vessel Registration Owner Declaration Required"
  end
end

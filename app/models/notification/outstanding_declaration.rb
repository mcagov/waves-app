class Notification::OutstandingDeclaration < Notification
  def email_template
    :outstanding_declaration
  end

  def email_params
    [
      notifiable.owner.email,
      notifiable.owner.name,
      notifiable.id,
    ]
  end
end

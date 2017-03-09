class Notification::NameApproval < Notification
  def email_template
    :name_approval
  end

  def additional_params
    [actioned_by, vessel_name, port_name]
  end

  def email_subject
    "Name Approved: #{vessel_name}"
  end

  private

  def vessel_name
    notifiable.vessel_name if notifiable
  end

  def port_name
    notifiable.vessel.port_name if notifiable
  end
end

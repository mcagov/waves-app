class Notification::ApplicationApproval < Notification
  def email_template
    :application_approval
  end

  def email_subject
    "Application Approved: #{vessel_name} - #{vessel_reg_no}"
  end

  def additional_params
    [vessel_reg_no, actioned_by, registration_certificate]
  end

  private

  def registration
    @registration ||= notifiable.registration
  end

  def vessel_reg_no
    registration.vessel.reg_no
  end

  def registration_certificate
    Certificate.new(registration, :attachment).render if attach_certificate?
  end

  def attach_certificate?
    attachments == "registration_certificate"
  end

  def vessel_name
    notifiable.vessel.name if notifiable.vessel
  end
end

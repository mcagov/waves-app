class Notification::ApplicationApproval < Notification
  def email_template
    :application_approval
  end

  def email_subject
    "Application Approved"
  end

  def additional_params
    [vessel_reg_no, registration_certificate]
  end

  private

  def vessel
    @vessel ||= notifiable.registration.vessel
  end

  def vessel_reg_no
    vessel.reg_no
  end

  def registration_certificate
    RegistrationCertificate.new(vessel).render if attach_certificate?
  end

  def attach_certificate?
    attachments == "registration_certificate"
  end
end

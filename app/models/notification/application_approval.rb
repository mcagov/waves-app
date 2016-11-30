class Notification::ApplicationApproval < Notification
  def email_template
    :application_approval
  end

  def email_subject
    "Application Approved: #{vessel_name} - #{vessel_reg_no}"
  end

  def additional_params
    [vessel_reg_no, actioned_by,
     notifiable.task, vessel_name, registration_certificate]
  end

  private

  def registration
    @registration ||=
      Registration.find_by(submission_ref_no: notifiable.ref_no)
  end

  def vessel_reg_no
    registered_vessel.reg_no if registered_vessel
  end

  def vessel_name
    registered_vessel.name if registered_vessel
  end

  def registered_vessel
    notifiable.registered_vessel if notifiable
  end

  def registration_certificate
    if attach_certificate?
      Pdfs::Certificate.new(registration, :attachment).render
    end
  end

  def attach_certificate?
    attachments == "registration_certificate"
  end
end

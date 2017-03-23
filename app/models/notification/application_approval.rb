class Notification::ApplicationApproval < Notification
  def email_template
    :application_approval
  end

  def email_subject
    "Application Approved: #{vessel_name} - #{vessel_reg_no}"
  end

  def additional_params
    [vessel_reg_no, actioned_by,
     notifiable.task, vessel_name, email_attachments]
  end

  private

  def registration
    @registration ||= notifiable.registration
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

  def email_attachments
    return if attachments.blank?

    Pdfs::Processor.run(attachments.to_sym, registration, :attachment).render
  end
end

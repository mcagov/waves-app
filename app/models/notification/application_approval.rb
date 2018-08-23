class Notification::ApplicationApproval < Notification
  def email_template
    :wysiwyg
  end

  def email_subject
    "UK ship registry, reference no: #{submission_ref_no}"
  end

  def additional_params
    [body, actioned_by, email_attachments]
  end

  private

  def submission_ref_no
    notifiable.ref_no
  end

  def registration
    @registration ||= notifiable.registration
  end

  def email_attachments
    return if attachments.blank?

    Pdfs::Processor.run(attachments.to_sym, registration, :attachment).render
  end
end

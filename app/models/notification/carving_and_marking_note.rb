class Notification::CarvingAndMarkingNote < Notification
  def email_template
    :wysiwyg
  end

  def additional_params
    [body, actioned_by, email_attachments]
  end

  def email_subject
    subject
  end

  private

  def vessel_name
    notifiable.vessel_name if notifiable
  end

  def email_attachments
    Array(attachments).map do |attachment|
      Pdfs::Processor.run(attachment.to_sym, notifiable, :attachment).render
    end
  end
end

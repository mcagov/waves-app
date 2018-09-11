class Notification::CarvingAndMarkingNote < Notification
  def email_template
    :carving_and_marking_note
  end

  def additional_params
    [register_length, actioned_by, email_attachments]
  end

  def email_subject
    "Carving & Marking Note: #{vessel_name}"
  end

  private

  def register_length
    (notifiable.register_length if notifiable).to_f
  end

  def vessel_name
    notifiable.vessel_name if notifiable
  end

  def email_attachments
    Pdfs::Processor.run(:carving_and_marking, notifiable, :attachment).render
  end
end

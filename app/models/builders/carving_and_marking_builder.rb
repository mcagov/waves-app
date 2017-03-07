class Builders::CarvingAndMarkingBuilder
  class << self
    def build(carving_and_marking)
      @carving_and_marking = carving_and_marking
      @submission = @carving_and_marking.submission

      Notification::CarvingAndMarkingNote.create(
        recipient_email: @submission.applicant_email,
        recipient_name: @submission.applicant_name,
        notifiable: @carving_and_marking,
        actioned_by: @carving_and_marking.issued_by,
        attachments: @carving_and_marking.template)
    end
  end
end

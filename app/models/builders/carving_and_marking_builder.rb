class Builders::CarvingAndMarkingBuilder
  class << self
    def build(carving_and_marking)
      @carving_and_marking = carving_and_marking
      @submission = @carving_and_marking.submission

      case @carving_and_marking.delivery_method.to_sym
      when :email
        build_notification
      when :print
        build_print_job
      end
    end

    private

    def build_notification
      Notification::CarvingAndMarkingNote.create(
        recipient_email: @submission.applicant_email,
        recipient_name: @submission.applicant_name,
        notifiable: @carving_and_marking,
        actioned_by: @carving_and_marking.actioned_by,
        attachments: :carving_and_marking)
    end

    def build_print_job
      PrintJob.create(
        printable: @carving_and_marking,
        part: @submission.part,
        template: :carving_and_marking,
        submission: @submission)
    end
  end
end

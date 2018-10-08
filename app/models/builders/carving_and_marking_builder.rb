class Builders::CarvingAndMarkingBuilder
  class << self
    def build(carving_and_marking, recipients)
      @carving_and_marking = carving_and_marking
      @recipients = recipients

      perform
    end

    private

    def perform
      if @carving_and_marking.emailable?
        build_notifications
      else
        build_print_job
      end
    end

    def build_notifications
      @recipients.each do |recipient|
        Notification::CarvingAndMarkingNote.create(
          recipient_email: recipient.email,
          recipient_name: recipient.name,
          notifiable: @carving_and_marking,
          actioned_by: @carving_and_marking.actioned_by,
          attachments: [:carving_and_marking])
      end
    end

    def build_print_job
      PrintJob.create(
        printable: @carving_and_marking,
        part: @carving_and_marking.part,
        template: :carving_and_marking,
        submission: @carving_and_marking.submission)
    end
  end
end

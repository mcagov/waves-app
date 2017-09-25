class CarvingAndMarkingReminder
  class << self
    def process
      load_remindable_submissions
      build_notifications
    end

    private

    def load_remindable_submissions
      @submissions =
        Submission.joins(:carving_and_markings)
                  .where("carving_and_marking_received_at IS NULL")
                  .includes(:carving_and_marking_reminder)
                  .where(notifications: { id: nil })
    end

    def build_notifications
      @submissions.each do |submission|
        Notification::CarvingAndMarkingReminder.create(
          notifiable: submission,
          recipient_name: submission.applicant_name,
          recipient_email: submission.applicant_email)
      end
    end
  end
end

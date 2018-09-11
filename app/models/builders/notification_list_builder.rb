class Builders::NotificationListBuilder
  class << self
    def for_submission(submission)
      (
        submission.correspondences +
        submission.notifications +
        submission.print_jobs +
        submission.declarations.map(&:notification) +
        carving_and_marking_notifications(submission)
      ).compact.sort { |a, b| b.created_at <=> a.created_at }
    end

    def for_registered_vessel(registered_vessel)
      submissions = registered_vessel.submissions
      (
        registered_vessel.correspondences +
        registered_vessel.notifications +
        submissions.map { |submission| for_submission(submission) }.flatten
      ).compact.sort { |a, b| b.created_at <=> a.created_at }
    end

    private

    def carving_and_marking_notifications(submission)
      submission.carving_and_markings.map(&:notifications).flatten.compact
    end
  end
end

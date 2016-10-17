class NotificationList
  class << self
    def for_submission(submission)
      @submission = submission
      (
        submission.correspondences +
        submission.notifications +
        submission.declarations.map(&:notification)
      ).compact.sort { |a, b| b.created_at <=> a.created_at }
    end

    def for_registered_vessel(registered_vessel, submissions)
      @registered_vessel = registered_vessel
      @submissions = submissions
      (
        @registered_vessel.correspondences +
        @submissions.map { |submission| for_submission(submission) }.flatten
      ).compact.sort { |a, b| b.created_at <=> a.created_at }
    end
  end
end

class Submission::OtherOpenTask
  class << self
    def for(submission)
      return [] unless submission.registered_vessel_id.present?
      Submission
        .where("registered_vessel_id = ?", submission.registered_vessel_id)
        .where.not(id: submission.id)
        .in_progress
    end
  end
end

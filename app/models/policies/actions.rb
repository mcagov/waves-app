class Policies::Actions
  class << self
    def registered_vessel_required?(submission)
      ApplicationType
        .new(submission.application_type)
        .registered_vessel_required?
    end

    def readonly?(task, user)
      task.blank? ||
        !task.claimed_by?(user) ||
        task.submission.closed?
    end
  end
end

class Policies::Actions
  class << self
    def actionable?(submission)
      return false if submission.closed?

      if Policies::Definitions.part_3_online?(submission)
        return Policies::Definitions.submission_errors(submission).empty?
      end

      true
    end

    def approvable?(task, user)
      task.claimed? && task.claimant == user
      # Policies::Definitions.approval_errors(task).empty?
    end

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

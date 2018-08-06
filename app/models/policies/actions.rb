class Policies::Actions
  class << self
    def actionable?(submission)
      return false if submission.closed?

      if Policies::Definitions.part_3_online?(submission)
        return Policies::Definitions.submission_errors(submission).empty?
      end

      true
    end

    def approvable?(submission)
      Policies::Definitions.approval_errors(submission).empty?
    end

    def editable?(submission)
      return false if Policies::Workflow.approved_name_required?(submission)
      !submission.closed?
    end

    def registered_vessel_required?(submission)
      ApplicationType
        .new(submission.application_type)
        .registered_vessel_required?
    end

    def readonly?(obj, user)
      if obj.is_a?(Submission)
        obj.closed?
      elsif obj.is_a?(Submission::Task)
        !(obj.current_state == :assigned && obj.claimant == user)
      end
    end
  end
end

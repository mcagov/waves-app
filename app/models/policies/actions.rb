class Policies::Actions
  class << self
    def actionable?(submission)
      return false if submission.completed?

      case submission.source.to_sym
      when :online
        Policies::Definitions.submission_errors(submission).empty?
      when :manual_entry
        true
      end
    end

    def approvable?(submission)
      Policies::Definitions.approval_errors(submission).empty?
    end

    def editable?(submission)
      return false if submission.officer_intervention_required?
      return false if Policies::Workflow.approved_name_required?(submission)
      !submission.completed?
    end

    def registered_vessel_required?(submission)
      task = submission.task.to_sym
      return false if Task.new(task).new_registration?
      return false if task == :unknown
      true
    end

    def readonly?(submission, user)
      !(submission.current_state == :assigned && submission.claimant == user)
    end
  end
end

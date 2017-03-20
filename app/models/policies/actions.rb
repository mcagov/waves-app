class Policies::Actions
  class << self
    def actionable?(submission)
      @submission = submission

      return false if @submission.completed?

      case @submission.source.to_sym
      when :online
        approvable?(submission)
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
      ![:unknown, :new_registration].include?(submission.task.to_sym)
    end

    def readonly?(submission, user)
      !(submission.current_state == :assigned && submission.claimant == user)
    end
  end
end

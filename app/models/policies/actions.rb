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
      return true if Task.new(submission.task) == :manual_override
      return false if submission.registration_status == :frozen
      return false unless submission.incomplete_declarations.empty?
      return false if AccountLedger.new(submission).awaiting_payment?
      true
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
    end
  end
end

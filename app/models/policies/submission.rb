class Policies::Submission
  class << self
    def actionable?(submission)
      @submission = submission

      case @submission.source.to_sym
      when :online
        approvable?(submission)
      when :manual_entry
        true
      end
    end

    def approvable?(submission)
      @submission = submission

      return false unless @submission.incomplete_declarations.empty?
      return false if AccountLedger.new(@submission).awaiting_payment?
      true
    end

    def editable?(submission)
      return false if submission.officer_intervention_required?
      !submission.completed?
    end

    def registered_vessel_required?(submission)
      ![:unknown, :new_registration].include?(submission.task.to_sym)
    end
  end
end

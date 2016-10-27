class Policies::Submission
  class << self
    def actionable?(submission)
      # for online part 3 registrations, this is the same as approvable?
      approvable?(submission)
    end

    def approvable?(submission)
      @submission = submission
      return false unless @submission.declarations.incomplete.empty?
      return false unless AccountLedger.paid?(@submission)
      true
    end

    def editable?(submission)
      !submission.completed? && !submission.printing?
    end

    def printing_completed?(submission)
      @submission = submission
      !@submission.print_jobs.map(&:last).include?(false)
    end

    def registered_vessel_required?(submission)
      return false if submission.officer_intervention_required?
      return false if submission.registered_vessel
      ![:unknown, :new_registration].include?(submission.task.to_sym)
    end
  end
end

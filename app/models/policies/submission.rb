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

      # disable approval for anything that is not a new_registration
      # we will remove this when we build out the other task approvals
      return false unless @submission.task.to_sym == :new_registration

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
      ![:unknown, :new_registration].include?(submission.task.to_sym)
    end
  end
end

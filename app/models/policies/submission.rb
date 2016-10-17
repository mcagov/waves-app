class Policies::Submission
  class << self
    def actionable?(submission)
      # for online part 3 registrations, this is the same as approvable?
      approvable?(submission)
    end

    def printing_completed?(submission)
      @submission = submission
      !@submission.print_jobs.map(&:last).include?(false)
    end

    def approvable?(submission)
      @submission = submission
      return false unless @submission.declarations.incomplete.empty?
      return false unless AccountLedger.paid?(@submission)
      true
    end
  end
end

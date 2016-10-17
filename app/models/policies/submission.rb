class Policies::Submission
  class << self
    def actionable?(submission)
      @submission = submission
      return false unless @submission.declarations.incomplete.empty?
      return false unless @submission.payment.present?
      true
    end

    def printing_completed?(submission)
      @submission = submission
      !@submission.print_jobs.map(&:last).include?(false)
    end

    def approvable?(_submission)
      actionable?
    end
  end
end

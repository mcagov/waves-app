class Policies::Submission
  class << self
    def actionable?(submission)
      @submission = submission
      return false unless @submission.declarations.incomplete.empty?
      return false unless @submission.payment.present?
      true
    end
  end
end

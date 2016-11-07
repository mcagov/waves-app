class AccountLedger
  class << self
    def payment_status(submission)
      @submission = submission

      return :not_applicable if amount_due(submission) == 0
      return :unpaid if @submission.payments.empty?
      return :paid if amount_paid(@submission) >= amount_due(@submission)
      :part_paid
    end

    def outstanding_payment?(submission)
      ![:not_applicable, :paid].include?(payment_status(submission))
    end

    def service_level(submission)
      amount_paid(submission) == 7500 ? :urgent : :standard
    end

    def amount_paid(submission)
      submission.payments.sum(&:amount).to_i
    end

    def amount_due(submission)
      @submission = submission
      if Task.payment_required?(@submission.task)
        2500
      else
        0
      end
    end
  end
end

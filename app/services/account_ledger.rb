class AccountLedger
  class << self
    def payment_status(submission)
      @submission = submission

      return :unpaid if @submission.payments.empty?
      return :paid if amount_paid(submission) >= 2500
      :part_paid
    end

    def amount_paid(submission)
      submission.payments.sum(&:amount).to_i
    end
  end
end

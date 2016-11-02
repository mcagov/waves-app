class AccountLedger
  class << self
    def payment_status(submission)
      @submission = submission

      return :unpaid if @submission.payments.empty?
      return :paid if @submission.payments.sum(:amount).to_i == 2500
      :part_paid
    end
  end
end

class AccountLedger
  class << self
    def paid?(submission)
      @submission = submission
      @submission.payment.present?
    end
  end
end

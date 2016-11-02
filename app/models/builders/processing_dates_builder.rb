class Builders::ProcessingDatesBuilder
  class << self
    def create(submission)
      @submission = submission
      @submission.update_attribute(:received_at, Date.today)
      @submission.update_attribute(:referred_until, nil)

      payment_amount = AccountLedger.amount_paid(submission)
      mode = payment_amount == 7500 ? :urgent : :standard
      target_date = TargetDate.new(Date.today, mode).calculate

      @submission.update_attribute(:is_urgent, true) if mode == :urgent
      @submission.update_attribute(:target_date, target_date)
    end
  end
end

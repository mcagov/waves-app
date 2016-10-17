class Builders::ProcessingDatesBuilder
  class << self
    def create(submission, payment_amount)
      @submission = submission
      @payment_amount = payment_amount

      @submission.update_attribute(:received_at, Date.today)

      if payment_amount == 7500
        @submission.update_attribute(:target_date, 5.days.from_now)
        @submission.update_attribute(:is_urgent, true)
      else
        @submission.update_attribute(:target_date, 20.days.from_now)
      end

      @submission.update_attribute(:referred_until, nil)
    end
  end
end

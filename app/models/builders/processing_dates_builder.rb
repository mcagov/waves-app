class Builders::ProcessingDatesBuilder
  class << self
    def create(submission)
      @submission = submission

      received_at = Date.today
      referred_until = nil
      service_level = FeeSchedule.new(@submission).service_level
      target_date = TargetDate.new(Date.today, service_level).calculate

      @submission.update_attributes(
        is_urgent: service_level == :premium,
        received_at: received_at,
        referred_until: referred_until,
        target_date: target_date)
    end
  end
end

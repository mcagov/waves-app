class Builders::ProcessingDatesBuilder
  class << self
    def create(submission)
      submission.update_attributes(
        received_at: Time.zone.today,
        referred_until: nil,
        target_date:
          TargetDate.new(
            Time.zone.today,
            submission.service_level,
            Service.first).calculate)
    end
  end
end

class Builders::ProcessingDatesBuilder
  class << self
    def create(submission)
      submission.update_attributes(
        received_at: Date.today,
        referred_until: nil,
        target_date:
          TargetDate.new(Date.today, submission.service_level).calculate)
    end
  end
end

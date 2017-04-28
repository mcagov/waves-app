class RegistrationDate
  class << self
    def for(submission, starts_at)
      RegistrationDate.new(starts_at, duration(submission))
    end

    def duration(submission)
      if Task.new(submission.task).provisional_registration?
        { days: 90 }
      else
        { years: 5 }
      end
    end
  end

  attr_reader :starts_at, :ends_at

  def initialize(starts_at, duration)
    @starts_at = ensure_date(starts_at)
    @ends_at = @starts_at.advance(duration)
  end

  private

  def ensure_date(input_date)
    input_date = DateTime.now if input_date.blank?
    input_date.to_datetime
  end
end

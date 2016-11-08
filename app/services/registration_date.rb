class RegistrationDate
  class << self
    def for(submission)
      starts_at =
        if Task.new(submission.task).renews_certificate?
          submission.registered_vessel.registered_until
        else
          DateTime.now
        end
      RegistrationDate.new(starts_at)
    end
  end

  attr_reader :starts_at, :ends_at

  def initialize(starts_at)
    @starts_at = ensure_date(starts_at)
    @ends_at = @starts_at.advance(years: 5)
  end

  private

  def ensure_date(input_date)
    input_date = DateTime.now if input_date.blank?
    input_date.to_datetime
  end
end

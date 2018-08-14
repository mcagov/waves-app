class RegistrationDate
  class << self
    def for(task)
      starts_at = start_date_for(task)
      RegistrationDate.new(starts_at, ends_at(task, starts_at))
    end

    private

    def start_date_for(task)
      registered_vessel = task.submission.try(:registered_vessel)
      return Time.zone.now unless registered_vessel.try(:registered_until)

      if registered_vessel.registered_until < Date.today.advance(months: 3)
        registered_vessel.registered_until
      else
        Time.zone.now
      end
    end

    def ends_at(task, starts_at)
      if Policies::Activities.new(task).generate_provisional_registration
        starts_at.advance(days: 90)
      elsif Policies::Activities.new(task).generate_new_5_year_registration
        starts_at.advance(years: 5)
      else
        task.submission.registered_vessel.registered_until
      end
    end
  end

  attr_reader :starts_at, :ends_at

  def initialize(starts_at, ends_at)
    @starts_at = ensure_date(starts_at)
    @ends_at = ends_at
  end

  private

  def ensure_date(input_date)
    input_date = DateTime.zone.now if input_date.blank?
    input_date.to_datetime
  end
end

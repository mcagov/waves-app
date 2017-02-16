class TargetDate
  def initialize(start_date, service_level)
    @start_date = start_date.advance(days: -1)
    @service_level = service_level
    set_business_days
  end

  def calculate
    number_of_days.business_days.after(@start_date)
  end

  private

  def number_of_days
    @service_level == :premium ? 3 : 10
  end

  def set_business_days
    Holiday.all.each do |holiday|
      BusinessTime::Config.holidays << holiday.holiday_date
    end
  end
end

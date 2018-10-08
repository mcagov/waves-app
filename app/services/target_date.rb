class TargetDate
  def initialize(start_date, service_level, service)
    @start_date = start_date
    @service_level = service_level.to_sym
    @service = service
  end

  def calculate
    TargetDate.set_business_days
    number_of_days.business_days.after(@start_date)
  end

  class << self
    def for_task(task)
      TargetDate.new(
        task.start_date, task.service_level, task.service
      ).calculate
    end

    def days_away(target_date)
      TargetDate.set_business_days
      day_diff = Date.current.business_days_until(target_date)
      return day_diff if day_diff > 0

      day_diff = target_date.business_days_until(Date.current)
      0 - day_diff
    end

    def formatted_days_away(target_date)
      return "" unless target_date

      day_diff = days_away(target_date)

      return "#{formatted_day_diff(day_diff)} away" if day_diff > 0
      return "Today" if day_diff.zero?
      "#{formatted_day_diff(0 - day_diff)} ago"
    end

    def formatted_day_diff(day_diff)
      "#{day_diff} day#{'s' if day_diff > 1}"
    end

    def set_business_days
      Rails.cache.fetch("target_date_holidays", expires_in: 12.hours) do
        Holiday.all.each do |holiday|
          BusinessTime::Config.holidays << holiday.holiday_date
        end
      end
    end
  end

  private

  def number_of_days
    @service_level == :premium ? @service.premium_days : @service.standard_days
  end
end

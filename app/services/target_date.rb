class TargetDate
  def initialize(start_date, service_level)
    @start_date = start_date.advance(days: -1)
    @service_level = service_level.present? ? service_level.to_sym : :standard
  end

  def calculate
    TargetDate.set_business_days
    number_of_days.business_days.after(@start_date)
  end

  class << self
    def days_away(target_date)
      return "" unless target_date
      TargetDate.set_business_days
      this_day = Date.today

      day_diff = this_day.business_days_until(target_date.to_date)
      return "#{formatted_day_diff(day_diff)} away" if day_diff > 0

      day_diff = target_date.to_date.business_days_until(this_day)
      return "Today" if day_diff.zero?
      "#{formatted_day_diff(day_diff)} ago"
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
    @service_level == :premium ? 3 : 10
  end
end

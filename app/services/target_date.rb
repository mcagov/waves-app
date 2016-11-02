class TargetDate
  def initialize(start_date, mode)
    @start_date = start_date.advance(days: -1)
    @mode = mode
    set_business_days
  end

  def calculate
    number_of_days.business_days.after(@start_date)
  end

  private

  def number_of_days
    @mode == :urgent ? 3 : 10
  end

  def set_business_days
    Holidays.between(
      @start_date, @start_date.advance(days: 30), :gb_wls).each do |holiday|

      BusinessTime::Config.holidays << holiday[:date]
    end
  end
end

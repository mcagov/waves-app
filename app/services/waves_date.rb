class WavesDate
  class << self
    def next_working_day(the_date)
      @the_date = the_date

      set_business_days
      return @the_date if @the_date.workday?

      next_working_day(@the_date.advance(days: 1))
    end

    private

    def set_business_days
      Holiday.all.each do |holiday|
        BusinessTime::Config.holidays << holiday.holiday_date
      end
    end
  end
end

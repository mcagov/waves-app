class WavesDates
  class << self
    def next_working_day(the_date)
      @the_date = the_date

      set_business_days
      return @the_date if @the_date.workday?

      next_working_day(@the_date.advance(days: 1))
    end

    private

    def set_business_days
      Holidays.between(
        @the_date, @the_date.advance(days: 7), :gb_wls).each do |holiday|

        BusinessTime::Config.holidays << holiday[:date]
      end
    end
  end
end

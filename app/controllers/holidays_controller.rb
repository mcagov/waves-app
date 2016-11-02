class HolidaysController < InternalPagesController
  def index
    @holidays = Holidays.between(Date.today, 5.year.from_now, :gb_wls)
  end
end

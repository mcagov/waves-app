class TargetDatesController < InternalPagesController
  def index
    @holidays = Holidays.between(Date.today, 4.year.from_now, :gb_wls)
    @start_date = start_date_params if params[:start_date]
    @start_date ||= Date.today
  end

  private

  def start_date_params
    Date.civil(
      params[:start_date][:year].to_i,
      params[:start_date][:month].to_i,
      params[:start_date][:day].to_i)
  rescue
    nil
  end
end

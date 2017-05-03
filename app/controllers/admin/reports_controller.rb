class Admin::ReportsController < InternalPagesController
  def show
    @report = Report.build(params[:id], filters)
  end

  protected

  def filters
    { part: current_activity.part }
  end
end

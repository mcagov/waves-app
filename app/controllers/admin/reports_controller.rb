class Admin::ReportsController < InternalPagesController
  def show
    @report = Report.build(params[:id], current_activity.part)
  end
end

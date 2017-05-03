class Admin::ReportsController < InternalPagesController
  def show
    @report = Report.find(params[:id])
  end
end

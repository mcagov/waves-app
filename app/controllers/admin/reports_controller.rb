class Admin::ReportsController < InternalPagesController
  def show
    @report = Report.new(params[:id])
  end
end

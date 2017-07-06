class Admin::ReportsController < InternalPagesController
  before_action :team_leader_only!

  def show
    @filter = filter_params || default_filter_params
    @filter[:page] = params[:page] || 1
    @report = Report.build(params[:id], @filter)

    respond_to do |format|
      format.html
      format.xls
    end
  end

  def index
    redirect_to admin_report_path(:staff_performance)
  end

  protected

  def filter_params
    return default_filter_params unless params[:filter]
    params.require(:filter).permit!
  end

  def default_filter_params
    { vessel: { name: { value: "", result_displayed: "1" } } }
  end
end

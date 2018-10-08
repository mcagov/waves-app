class Admin::ReportsController < InternalPagesController
  before_action :system_manager_only!

  def show
    @filter = filter_params || default_filter_params

    respond_to do |format|
      format.html { html_report }
      format.xls { xls_report }
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

  def build_report
    @report = Report.build(params[:id], @filter)
  end

  def html_report
    @filter[:page] = params[:page] || 1
    @filter[:per_page] = 50
    build_report
  end

  def xls_report
    @filter[:page] = 1
    @filter[:per_page] = 10000
    build_report
  end
end

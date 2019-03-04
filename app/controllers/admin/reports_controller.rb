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

  def html_report
    @filter[:page] = params[:page] || 1
    @filter[:per_page] = 50

    @report = Report.build(params[:id], @filter)
  end

  def xls_report
    DownloadableReport.delay.build_and_notify(
      current_user, Report.build(params[:id], @filter))

    redirect_key = params[:id].gsub("_report", "")

    flash[:notice] =
      "You will shortly receive an email with a link to download the report"
    redirect_to "/admin/reports/#{redirect_key}?#{request.query_string}"
  end
end

class Admin::ReportsController < InternalPagesController
  def show
    @filter = filter_params
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
    # to do: enable dynamic attribute
    return {} unless params[:filter]
    params.require(:filter).permit(
      :part, :date_start, :date_end,
      :task, :registration_status, :document_type,
      vessel: [:name, :hin])
  end
end

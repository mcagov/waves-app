class Admin::ReportsController < InternalPagesController
  def show
    @filter = filter_params
    @report = Report.build(params[:id], @filter)

    respond_to do |format|
      format.html
      format.xls
    end
  end

  protected

  def filter_params
    return {} unless params[:filter]
    params.require(:filter).permit(
      :part, :date_start, :date_end, :task, :registration_status)
  end
end

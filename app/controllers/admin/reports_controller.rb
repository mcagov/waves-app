class Admin::ReportsController < InternalPagesController
  def show
    @filter = filter_params
    @report = Report.build(params[:id], @filter)
  end

  protected

  def filter_params
    return {} unless params[:filter]
    params.require(:filter).permit(:part)
  end
end

class WorkLogsController < InternalPagesController
  def index
    assign_work_logs
  end

  private

  def assign_work_logs
    @work_logs =
      WorkLog
      .in_part(params[:part])
      .includes(:actioned_by, :loggable)
      .order(created_at: :desc)
      .paginate(page: params[:page], per_page: 50)
  end
end

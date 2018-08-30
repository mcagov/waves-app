class WorkLogsController < InternalPagesController
  def index
    @work_logs =
      WorkLog
      .where(part: current_activity.part)
      .includes(:actioned_by, :loggable)
      .order(created_at: :desc)
      .paginate(page: params[:page], per_page: 50)
  end
end

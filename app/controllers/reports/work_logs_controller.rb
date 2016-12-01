class Reports::WorkLogsController < InternalPagesController
  def index
    @work_logs =
      WorkLog.in_part(current_activity.part)
             .includes(:submission, :actioned_by)
             .paginate(page: params[:page], per_page: 50)
  end
end

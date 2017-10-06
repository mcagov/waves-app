class Reports::WorkLogsController < InternalPagesController
  def index
    @work_logs =
      WorkLog.includes(:submission, :actioned_by)
             .paginate(page: params[:page], per_page: 50)
  end
end

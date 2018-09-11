class WorkLogsController < InternalPagesController
  def index
    assign_work_logs
  end

  private

  def assign_work_logs
    @work_logs =
      WorkLog
      .in_part(filter_params[:part])
      .actioned_by(filter_params[:actioned_by_id])
      .date_start(filter_params[:date_start])
      .date_end(filter_params[:date_end])
      .includes(:actioned_by, task: [:submission])
      .order(created_at: :desc)
      .paginate(page: params[:page], per_page: 50)
  end

  def filter_params
    @filter_params ||=
      {
        part: params[:part].presence,
        date_start: params[:date_start].presence,
        date_end: params[:date_end].presence,
        actioned_by_id: params[:actioned_by_id].presence,
      }
  end
end

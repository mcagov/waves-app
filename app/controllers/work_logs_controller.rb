class WorkLogsController < InternalPagesController
  include WorkLogs

  def index
    assign_work_logs
  end
end

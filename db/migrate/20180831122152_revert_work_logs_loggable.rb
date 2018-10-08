class RevertWorkLogsLoggable < ActiveRecord::Migration[5.2]
  def change
    add_column :work_logs, :task_id, :uuid, index: true
    remove_column :work_logs, :loggable_id, :uuid, index: true
    remove_column :work_logs, :loggable_type, :string, index: true
  end
end

class RebuildWorkLogs < ActiveRecord::Migration[5.2]
  def change
    remove_column :work_logs, :submission_task_id, index: true
    remove_column :work_logs, :logged_type, :string, index: true
    add_column :work_logs, :loggable_id, :uuid, index: true
    add_column :work_logs, :loggable_type, :string, index: true
  end
end

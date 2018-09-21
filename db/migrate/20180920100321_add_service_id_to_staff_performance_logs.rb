class AddServiceIdToStaffPerformanceLogs < ActiveRecord::Migration[5.2]
  def change
    add_column :staff_performance_logs, :service_id, :uuid
  end
end

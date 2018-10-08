class AddWithinStandardToStaffPerformanceLogs < ActiveRecord::Migration[5.2]
  def change
    add_column :staff_performance_logs, :within_standard, :boolean, default: false
  end
end

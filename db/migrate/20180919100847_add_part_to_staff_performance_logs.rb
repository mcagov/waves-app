class AddPartToStaffPerformanceLogs < ActiveRecord::Migration[5.2]
  def change
    add_column :staff_performance_logs, :part, :string, index: true
  end
end

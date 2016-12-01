class AddPartToWorkLogs < ActiveRecord::Migration[5.0]
  def change
    add_column :work_logs, :part, :string, index: true
  end
end

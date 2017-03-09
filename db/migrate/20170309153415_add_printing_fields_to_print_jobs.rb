class AddPrintingFieldsToPrintJobs < ActiveRecord::Migration[5.0]
  def change
    add_column :print_jobs, :state, :string, index: true
    add_column :print_jobs, :printing_by_id, :uuid
    add_column :print_jobs, :printing_at, :datetime
  end
end

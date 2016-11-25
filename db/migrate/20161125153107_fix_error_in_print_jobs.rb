class FixErrorInPrintJobs < ActiveRecord::Migration[5.0]
  def change
    rename_column :print_jobs, :printed_by, :printed_by_id
  end
end

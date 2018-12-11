class AddAddedByToPrintJobs < ActiveRecord::Migration[5.2]
  def change
    add_column :print_jobs, :added_by_id, :uuid, index: true
  end
end

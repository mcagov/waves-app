class AddPartToPrintJobs < ActiveRecord::Migration[5.0]
  def change
    add_column :print_jobs, :part, :string, index: true
  end
end

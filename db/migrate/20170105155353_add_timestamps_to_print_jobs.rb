class AddTimestampsToPrintJobs < ActiveRecord::Migration[5.0]
  def change
    add_column(:print_jobs, :created_at, :datetime)
    add_column(:print_jobs, :updated_at, :datetime)
  end
end

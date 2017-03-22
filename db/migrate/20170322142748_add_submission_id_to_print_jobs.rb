class AddSubmissionIdToPrintJobs < ActiveRecord::Migration[5.0]
  def change
    add_column :print_jobs, :submission_id, :uuid
  end
end

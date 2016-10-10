class AddPrintJobsToSubmissions < ActiveRecord::Migration[5.0]
  def change
    add_column :submissions, :print_jobs, :json
  end
end

class RemovePrintJobsFromSubmissions < ActiveRecord::Migration[5.0]
  def change
    remove_column :submissions, :print_jobs, :json
  end
end
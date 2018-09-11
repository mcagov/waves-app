class RenameCompletedAtSubmissions < ActiveRecord::Migration[5.2]
  def change
    rename_column :submissions, :completed_at, :closed_at
  end
end

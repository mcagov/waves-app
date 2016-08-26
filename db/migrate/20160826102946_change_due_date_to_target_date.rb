class ChangeDueDateToTargetDate < ActiveRecord::Migration[5.0]
  def change
    rename_column :submissions, :due_date, :target_date
  end
end

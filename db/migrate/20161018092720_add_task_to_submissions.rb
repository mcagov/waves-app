class AddTaskToSubmissions < ActiveRecord::Migration[5.0]
  def change
    add_column :submissions, :task, :string, index: true
  end
end

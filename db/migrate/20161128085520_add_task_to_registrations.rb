class AddTaskToRegistrations < ActiveRecord::Migration[5.0]
  def change
    add_column :registrations, :task, :string
  end
end

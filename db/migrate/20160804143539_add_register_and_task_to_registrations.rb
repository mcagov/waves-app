class AddRegisterAndTaskToRegistrations < ActiveRecord::Migration[5.0]
  def change
    add_column :registrations, :register, :string
    add_column :registrations, :task, :string
    add_index :registrations, :register
    add_index :registrations, :task
  end
end

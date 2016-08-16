class RemoveStatusFromRegistrations < ActiveRecord::Migration[5.0]
  def change
    remove_column :registrations, :status
  end
end

class AddStateToNotifications < ActiveRecord::Migration[5.0]
  def change
    remove_column :notifications, :delivered, :boolean
    add_column :notifications, :state, :string
    add_index :notifications, :state
  end
end

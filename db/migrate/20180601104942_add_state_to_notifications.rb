class AddStateToNotifications < ActiveRecord::Migration[5.2]
  def change
    add_column :notifications, :state, :string, index: true
    add_column :notifications, :delivered_at, :datetime
    add_column :notifications, :approved_at, :datetime
    add_column :notifications, :approved_by_id, :uuid
  end
end

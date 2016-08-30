class AddActionedByToNotifications < ActiveRecord::Migration[5.0]
  def change
    add_column :notifications, :actioned_by_id, :uuid
  end
end

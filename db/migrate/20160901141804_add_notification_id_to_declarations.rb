class AddNotificationIdToDeclarations < ActiveRecord::Migration[5.0]
  def change
    add_column :declarations, :notification_id, :uuid
    add_index :declarations, :notification_id
  end
end

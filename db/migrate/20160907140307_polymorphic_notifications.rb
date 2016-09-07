class PolymorphicNotifications < ActiveRecord::Migration[5.0]
  def change
    remove_column :notifications, :submission_id, :uuid
    add_column :notifications, :notifiable_id, :uuid
    add_column :notifications, :notifiable_type, :string
    add_index :notifications, :notifiable_id
    add_index :notifications, :notifiable_type
  end
end

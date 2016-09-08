class AddRecipientToNotifications < ActiveRecord::Migration[5.0]
  def change
    add_column :notifications, :recipient_name, :string
    add_column :notifications, :recipient_email, :string
  end
end

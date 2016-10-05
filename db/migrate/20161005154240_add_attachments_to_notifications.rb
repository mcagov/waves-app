class AddAttachmentsToNotifications < ActiveRecord::Migration[5.0]
  def change
    add_column :notifications, :attachments, :string
  end
end

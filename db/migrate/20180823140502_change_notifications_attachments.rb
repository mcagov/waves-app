class ChangeNotificationsAttachments < ActiveRecord::Migration[5.2]
  def change
    remove_column :notifications, :attachments, :string
    add_column :notifications, :attachments, :json, default: []
  end
end

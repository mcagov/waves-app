class AddTimestampsToNotifications < ActiveRecord::Migration[5.0]
  def change
    change_table :notifications do |t|
      t.timestamps
    end
  end
end

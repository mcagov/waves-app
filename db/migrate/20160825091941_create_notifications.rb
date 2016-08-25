class CreateNotifications < ActiveRecord::Migration[5.0]
  def change
    create_table :notifications do |t|
      t.uuid :submission_id
      t.string :type, index: true
      t.string :subject
      t.text :body
      t.boolean :delivered, default: false
    end
  end
end

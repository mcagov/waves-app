class AddRecipientsToNotes < ActiveRecord::Migration[5.2]
  def change
    add_column :notes, :recipients, :json, default: []
  end
end

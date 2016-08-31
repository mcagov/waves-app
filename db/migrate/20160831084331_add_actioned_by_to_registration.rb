class AddActionedByToRegistration < ActiveRecord::Migration[5.0]
  def change
    add_column :registrations, :actioned_by_id, :uuid
    add_index :registrations, :actioned_by_id
  end
end

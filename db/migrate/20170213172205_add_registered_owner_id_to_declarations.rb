class AddRegisteredOwnerIdToDeclarations < ActiveRecord::Migration[5.0]
  def change
    add_column :declarations, :registered_owner_id, :uuid
  end
end

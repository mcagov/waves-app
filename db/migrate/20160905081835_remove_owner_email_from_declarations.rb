class RemoveOwnerEmailFromDeclarations < ActiveRecord::Migration[5.0]
  def change
    remove_column :declarations, :owner_email, :string
  end
end

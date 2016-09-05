class AddOwnerToDeclarations < ActiveRecord::Migration[5.0]
  def change
    add_column :declarations, :owner, :json
  end
end

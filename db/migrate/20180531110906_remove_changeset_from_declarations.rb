class RemoveChangesetFromDeclarations < ActiveRecord::Migration[5.2]
  def change
    remove_column :declarations, :changeset, :json
  end
end

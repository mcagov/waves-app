class AddCompletedByToDeclarations < ActiveRecord::Migration[5.0]
  def change
    add_column :declarations, :completed_by_id, :uuid
    add_index :declarations, :completed_by_id
  end
end

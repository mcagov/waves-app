class AddCompletedAtToDeclarations < ActiveRecord::Migration[5.0]
  def change
    add_column :declarations, :completed_at, :datetime
  end
end

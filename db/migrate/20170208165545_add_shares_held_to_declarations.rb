class AddSharesHeldToDeclarations < ActiveRecord::Migration[5.0]
  def change
    add_column :declarations, :shares_held, :integer, default: 0
  end
end

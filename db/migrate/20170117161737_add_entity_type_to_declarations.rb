class AddEntityTypeToDeclarations < ActiveRecord::Migration[5.0]
  def change
    add_column :declarations, :entity_type, :string, default: :individual, index: true
  end
end

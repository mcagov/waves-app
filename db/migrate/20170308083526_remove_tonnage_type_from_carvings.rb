class RemoveTonnageTypeFromCarvings < ActiveRecord::Migration[5.0]
  def change
    remove_column :carving_and_markings, :tonnage_type, :string
  end
end

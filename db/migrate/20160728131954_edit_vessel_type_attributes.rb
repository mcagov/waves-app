class EditVesselTypeAttributes < ActiveRecord::Migration[5.0]
  def change
    remove_column :vessel_types, :designation, :string
    add_column :vessel_types, :name, :string
    add_column :vessel_types, :key, :string
  end
end

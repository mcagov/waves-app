class AddVesselTypeIndex < ActiveRecord::Migration[5.0]
  def change
    add_index :vessels, :vessel_type
  end
end

class RemoveVesselTypeIdFromVessels < ActiveRecord::Migration[5.0]
  def change
    remove_column :vessels, :vessel_type_id, :integer
    add_column :vessels, :vessel_type, :string
  end
end

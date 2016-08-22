class RemoveVesselTypeOtherFromVessels < ActiveRecord::Migration[5.0]
  def change
    remove_column :vessels, :vessel_type_other, :string
  end
end

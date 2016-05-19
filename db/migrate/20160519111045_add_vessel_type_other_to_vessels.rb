class AddVesselTypeOtherToVessels < ActiveRecord::Migration
  def change
    add_column :vessels, :vessel_type_other, :string
  end
end

class UpdateVesselFields < ActiveRecord::Migration[5.0]
  def change
    remove_column :vessels, :yard_number, :string
    add_column :vessels, :country_of_build, :string
  end
end

class RemoveMmsiConstraintFromVessels < ActiveRecord::Migration[5.0]
  def change
    change_column :vessels, :mmsi_number, :integer, null: true
  end
end

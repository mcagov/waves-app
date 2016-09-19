class AddIndexToVessels < ActiveRecord::Migration[5.0]
  def change
    add_index :vessels, :name
    add_index :vessels, :mmsi_number
    add_index :vessels, :hin
    add_index :vessels, :radio_call_sign
  end
end

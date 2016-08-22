class ChangeLengthTypeInVessels < ActiveRecord::Migration[5.0]
  def change
    remove_column :vessels, :length_in_centimeters, :integer
    add_column :vessels, :length_in_meters, :decimal
  end
end

class RemoveEcNumberFromVessels < ActiveRecord::Migration[5.0]
  def change
    remove_column :vessels, :ec_number, :string
  end
end

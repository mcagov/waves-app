class ChangeMmsiNumber < ActiveRecord::Migration[5.0]
  def change
    change_column :vessels, :mmsi_number, :string
  end
end

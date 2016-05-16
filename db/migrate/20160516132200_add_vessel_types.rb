class AddVesselTypes < ActiveRecord::Migration
  def change
    create_table :vessel_types do |t|
      t.string :designation, null: false

      t.timestamps null: false
    end
  end
end

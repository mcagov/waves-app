class AddVesselRegistrations < ActiveRecord::Migration
  def change
    create_table :vessel_registrations do |t|
      t.integer :vessel_id, references: :vessels
      t.integer :registration_id, references: :registrations

      t.timestamps null: false
    end
  end
end

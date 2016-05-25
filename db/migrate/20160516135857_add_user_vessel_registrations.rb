class AddUserVesselRegistrations < ActiveRecord::Migration
  def change
    create_table :user_vessel_registrations do |t|
      t.integer :user_id, references: :users
      t.integer :vessel_registration_id, references: :vessel_registration_id

      t.json :changes, null: false, default: "{}"

      t.timestamps null: false
    end
  end
end

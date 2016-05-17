class AddRegisterVessels < ActiveRecord::Migration
  def change
    create_table :register_vessels do |t|
      t.integer :register_id, references: :registers
      t.integer :vessel_id, references: :vessels

      t.string :status, null: false
      t.datetime :expiry_date, null: false
      t.integer :register_number, null: false

      t.timestamps null: false
    end
  end
end

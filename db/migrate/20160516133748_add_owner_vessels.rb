class AddOwnerVessels < ActiveRecord::Migration
  def change
    create_table :owner_vessels do |t|
      t.integer :owner_id, references: :owners
      t.integer :vessel_id, references: :vessels

      t.timestamps null: false
    end
  end
end

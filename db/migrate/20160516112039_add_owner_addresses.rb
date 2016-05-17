class AddOwnerAddresses < ActiveRecord::Migration
  def change
    create_table :owner_addresses do |t|
      t.integer :owner_id, references: :owners
      t.integer :address_id, references: :addresses

      t.timestamps null: false
    end
  end
end

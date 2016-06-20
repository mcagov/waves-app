class DropOwnerAddresses < ActiveRecord::Migration
  def up
    OwnerAddress.all.find_each do |owner_address|
      owner = owner_address.owner
      address = owner_address.address

      owner.update_attribute("address_id", address.id) unless address.nil?
    end

    drop_table :owner_addresses
  end

  def down
    create_table :owner_addresses do |t|
      t.integer :owner_id, references: :owners
      t.integer :address_id, references: :addresses

      t.timestamps null: false
    end

    Owner.all.find_each do |owner|
      address = owner.address

      OwnerAddress.create(
        owner: owner,
        address: address
      ) if address
    end
  end
end

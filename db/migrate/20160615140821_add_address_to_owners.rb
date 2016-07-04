class AddAddressToOwners < ActiveRecord::Migration
  def change
    add_column :owners, :address_id, :integer
  end
end

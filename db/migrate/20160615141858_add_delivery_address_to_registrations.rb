class AddDeliveryAddressToRegistrations < ActiveRecord::Migration
  def change
    add_column :registrations, :delivery_address_id, :integer
  end
end

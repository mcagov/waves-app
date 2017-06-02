class AddAltAddressToCustomers < ActiveRecord::Migration[5.0]
  def change
    add_column :customers, :alt_address_1, :string
    add_column :customers, :alt_address_2, :string
    add_column :customers, :alt_address_3, :string
    add_column :customers, :alt_town, :string
    add_column :customers, :alt_country, :string
    add_column :customers, :alt_postcode, :string
  end
end

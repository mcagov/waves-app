class PolymorphicCustomers < ActiveRecord::Migration[5.0]
  def change
    add_column :customers, :parent_id, :uuid, index: true
    add_column :customers, :parent_type, :string, index: true
    remove_column :customers, :vessel_id, :uuid
  end
end

class AddRoleFieldsToCustomers < ActiveRecord::Migration[5.0]
  def change
    add_column :customers, :managing_owner, :boolean, default: false
    add_column :customers, :correspondent, :boolean, default: false
  end
end

class AddCustomBooleanToCustomers < ActiveRecord::Migration[5.1]
  def change
    add_column :customers, :custom_boolean, :boolean, default: false
  end
end

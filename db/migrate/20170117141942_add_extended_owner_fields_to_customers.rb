class AddExtendedOwnerFieldsToCustomers < ActiveRecord::Migration[5.0]
  def change
    add_column :customers, :imo_number, :string
    add_column :customers, :eligibility_status, :string
  end
end

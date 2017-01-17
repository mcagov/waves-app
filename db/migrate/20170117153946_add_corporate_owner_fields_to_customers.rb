class AddCorporateOwnerFieldsToCustomers < ActiveRecord::Migration[5.0]
  def change
    add_column :customers, :registration_number, :string
    add_column :customers, :date_of_incorporation, :datetime
  end
end

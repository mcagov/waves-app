class AddSharesHeldToCustomer < ActiveRecord::Migration[5.0]
  def change
    add_column :customers, :shares_held, :integer
  end
end

class AddApplicationRefNoToFinancePayments < ActiveRecord::Migration[5.0]
  def change
    add_column :finance_payments, :application_ref_no, :string
  end
end

class AddPayerNameToFinancePayments < ActiveRecord::Migration[5.0]
  def change
    add_column :finance_payments, :payer_name, :string
  end
end

class AddPaymentReferenceToFinancePayments < ActiveRecord::Migration[5.2]
  def change
    add_column :finance_payments, :payment_reference, :string
  end
end

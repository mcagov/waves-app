class AddPaymentDateToFinancePayments < ActiveRecord::Migration[5.0]
  def change
    add_column :finance_payments, :payment_date, :date
  end
end

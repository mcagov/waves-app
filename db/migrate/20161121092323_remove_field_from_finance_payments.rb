class RemoveFieldFromFinancePayments < ActiveRecord::Migration[5.0]
  def change
    remove_column :finance_payments, :submission_ref_no, :string
    remove_column :finance_payments, :receipt_no, :string
  end
end

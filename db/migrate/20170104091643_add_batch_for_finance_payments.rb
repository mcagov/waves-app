class AddBatchForFinancePayments < ActiveRecord::Migration[5.0]
  def change
    add_column :finance_payments, :batch_id, :uuid, index: true
  end
end

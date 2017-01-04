class AddBatchNoToFinancePaymentBatches < ActiveRecord::Migration[5.0]
  def change
    add_column :finance_payment_batches, :batch_no, :integer
  end
end

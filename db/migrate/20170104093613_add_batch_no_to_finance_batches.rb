class AddBatchNoToFinanceBatches < ActiveRecord::Migration[5.0]
  def change
    add_column :finance_batches, :batch_no, :integer
  end
end

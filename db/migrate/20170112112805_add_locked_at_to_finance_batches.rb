class AddLockedAtToFinanceBatches < ActiveRecord::Migration[5.0]
  def change
    add_column :finance_batches, :locked_at, :datetime
  end
end

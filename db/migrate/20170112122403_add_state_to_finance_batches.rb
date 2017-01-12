class AddStateToFinanceBatches < ActiveRecord::Migration[5.0]
  def change
    add_column :finance_batches, :state, :string, index: true
  end
end

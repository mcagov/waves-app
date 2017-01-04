class CreateFinanceBatches < ActiveRecord::Migration[5.0]
  def change
    create_table :finance_batches, id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
      t.uuid :finance_payment_id, index: true
      t.datetime :opened_at
      t.datetime :closed_at
      t.uuid :processed_by_id
      t.timestamps
    end
  end
end

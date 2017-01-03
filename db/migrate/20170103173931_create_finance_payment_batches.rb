class CreateFinancePaymentBatches < ActiveRecord::Migration[5.0]
  def change
    create_table :finance_payment_batches, id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
      t.uuid :finance_payment_id, index: true
      t.datetime :starts_at
      t.uuid :started_by_id
      t.datetime :ends_at
      t.uuid :ended_by_id
      t.timestamps
    end
  end
end

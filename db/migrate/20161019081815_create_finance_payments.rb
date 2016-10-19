class CreateFinancePayments < ActiveRecord::Migration[5.0]
  def change
    create_table :finance_payments, id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
      t.string   :part
      t.string   :task
      t.string   :vessel_reg_no
      t.string   :vessel_name
      t.string   :service_level
      t.string   :payment_type
      t.integer   :payment_amount
      t.string   :receipt_no
      t.string   :applicant_name
      t.string   :applicant_email
      t.string   :documents_received
      t.uuid     :actioned_by_id, index: true
      t.timestamps
    end
  end
end

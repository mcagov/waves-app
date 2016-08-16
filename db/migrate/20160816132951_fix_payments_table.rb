class FixPaymentsTable < ActiveRecord::Migration[5.0]
  def up
    drop_table "payments"

    create_table "payments", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
      t.uuid  "registration_id"
      t.datetime "created_at",          null: false
      t.datetime "updated_at",          null: false
      t.string   "wp_token"
      t.string   "wp_order_code"
      t.string   "wp_amount"
      t.string   "wp_country"
      t.string   "customer_ip"
      t.json     "wp_payment_response"
      t.index ["registration_id"], name: "index_payments_on_registration_id", using: :btree
    end
  end
end

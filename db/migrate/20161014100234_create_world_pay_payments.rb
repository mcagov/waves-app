class CreateWorldPayPayments < ActiveRecord::Migration[5.0]
  def change
    create_table :world_pay_payments, id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
      t.string   :wp_token
      t.string   :wp_order_code
      t.string   :wp_country
      t.string   :customer_ip
      t.json     :wp_payment_response
      t.timestamps
    end

    remove_column :payments, :wp_token, :string
    remove_column :payments, :wp_order_code, :string
    remove_column :payments, :wp_country, :string
    remove_column :payments, :customer_ip, :string
    remove_column :payments, :wp_amount, :string
    remove_column :payments, :wp_payment_response, :json

    add_column :payments, :remittance_type, :string
    add_column :payments, :remittance_id, :uuid
    add_column :payments, :amount, :integer

    add_index :payments, :remittance_type
    add_index :payments, :remittance_id
  end
end

class AddWpFieldsToPayments < ActiveRecord::Migration[5.0]
  def change
    remove_column :payments, :changeset, :string
    add_column :payments, :wp_token, :string
    add_column :payments, :wp_order_code, :string
    add_column :payments, :wp_amount, :string
    add_column :payments, :wp_country, :string
    add_column :payments, :customer_ip, :string
    add_column :payments, :wp_payment_response, :json
  end
end


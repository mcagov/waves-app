class RemoveUnavailableWorldPayColumns < ActiveRecord::Migration[5.0]
  def change
    remove_column :world_pay_payments, :wp_token, :string
    remove_column :world_pay_payments, :wp_order_code, :string
    remove_column :world_pay_payments, :wp_country, :string
    remove_column :world_pay_payments, :wp_payment_response, :json
  end
end

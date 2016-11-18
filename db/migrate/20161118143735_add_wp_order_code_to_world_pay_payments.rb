class AddWpOrderCodeToWorldPayPayments < ActiveRecord::Migration[5.0]
  def change
    add_column :world_pay_payments, :wp_order_code, :string
  end
end

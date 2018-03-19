class AddServiceLevelToFinancePayments < ActiveRecord::Migration[5.2]
  def change
    add_column :finance_payments, :service_level, :integer, default: 0
  end
end

class RemoveServiceLevelFromFinancePayments < ActiveRecord::Migration[5.0]
  def change
    remove_column :finance_payments, :service_level, :string
  end
end

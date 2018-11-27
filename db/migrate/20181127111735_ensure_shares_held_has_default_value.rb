class EnsureSharesHeldHasDefaultValue < ActiveRecord::Migration[5.2]
  def change
    change_column_default :customers, :shares_held, 0
    change_column_default :shareholder_groups, :shares_held, 0
  end
end

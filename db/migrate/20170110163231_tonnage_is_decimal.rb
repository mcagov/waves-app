class TonnageIsDecimal < ActiveRecord::Migration[5.0]
  def up
    change_column :vessels, :net_tonnage, :decimal
    change_column :vessels, :gross_tonnage, :decimal
  end

  def down
    change_column :vessels, :net_tonnage, :integer
    change_column :vessels, :gross_tonnage, :integer
  end
end

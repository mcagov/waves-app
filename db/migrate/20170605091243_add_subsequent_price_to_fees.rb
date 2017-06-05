class AddSubsequentPriceToFees < ActiveRecord::Migration[5.0]
  def change
    add_column :fees, :subsequent_price, :integer
  end
end

class RemoveMortgagorFromMortgages < ActiveRecord::Migration[5.0]
  def change
    remove_column :mortgages, :mortgagor, :string
  end
end

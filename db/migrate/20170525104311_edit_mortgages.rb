class EditMortgages < ActiveRecord::Migration[5.0]
  def change
    rename_column :mortgages, :start_date, :executed_at
    add_column :mortgages, :priority_code, :string, index: true
    add_column :mortgages, :registered_at, :datetime
    add_column :mortgages, :discharged_at, :datetime
  end
end

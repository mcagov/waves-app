class EditMortgageDates < ActiveRecord::Migration[5.0]
  def change
    remove_column :mortgages, :end_date, :date
    change_column :mortgages, :start_date, :datetime
  end
end

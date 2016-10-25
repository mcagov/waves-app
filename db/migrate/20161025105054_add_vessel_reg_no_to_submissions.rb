class AddVesselRegNoToSubmissions < ActiveRecord::Migration[5.0]
  def change
    add_column :submissions, :vessel_reg_no, :string, index: true
  end
end

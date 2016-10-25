class RemoveVesselRegNoFromSubmissions < ActiveRecord::Migration[5.0]
  def change
    remove_column :submissions, :vessel_reg_no, :string
    remove_column :submissions, :vessel_id, :uuid
    add_column :submissions, :registered_vessel_id, :uuid, index: true
  end
end

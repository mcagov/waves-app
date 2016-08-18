class RemoveVesselIdFromSubmissions < ActiveRecord::Migration[5.0]
  def change
    remove_column :submissions, :vessel_id, :uuid
  end
end

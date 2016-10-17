class AddVesselIdToSubmissions < ActiveRecord::Migration[5.0]
  def change
    add_column :submissions, :vessel_id, :uuid
  end
end

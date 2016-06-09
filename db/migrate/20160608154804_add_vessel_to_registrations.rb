class AddVesselToRegistrations < ActiveRecord::Migration
  def change
    add_column :registrations, :vessel_id, :integer
  end
end

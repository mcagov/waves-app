class RemoveVesselRegistrationFromUserVesselRegistrations < ActiveRecord::Migration
  def change
    remove_column :user_vessel_registrations, :vessel_registration_id, :integer
  end
end

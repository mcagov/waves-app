class AddRegistrationToUserVesselRegistrations < ActiveRecord::Migration
  def change
    add_column :user_vessel_registrations, :registration_id, :integer
  end
end

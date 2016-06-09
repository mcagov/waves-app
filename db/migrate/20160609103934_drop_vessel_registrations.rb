class DropVesselRegistrations < ActiveRecord::Migration
  def up
    VesselRegistration.all.find_each do |vessel_registration|
      registration = vessel_registration.registration
      vessel = vessel_registration.vessel

      registration.update_attribute("vessel_id", vessel.id) unless vessel.nil?

      scope = {vessel_registration_id: vessel_registration.id}
      update_user_vessel_registrations(
        scope, "registration_id", registration.id
      )
    end

    drop_table :vessel_registrations
  end

  def down
    create_table :vessel_registrations do |t|
      t.integer :vessel_id, references: :vessels
      t.integer :registration_id, references: :registrations

      t.timestamps null: false
    end

    Registration.all.find_each do |registration|
      vessel = registration.vessel

      vessel_registration = VesselRegistration.create(
        registration: registration,
        vessel: vessel
      )

      scope = {registration_id: registration.id}
      update_user_vessel_registrations(
        scope, "vessel_registration_id", vessel_registration.id
      )
    end
  end

  private

  def update_user_vessel_registrations(scope, attribute_name, attribute_value)
    UserVesselRegistration.where(scope).each do |user_vessel_registration|
      user_vessel_registration.update_attribute(attribute_name, attribute_value)
    end
  end
end

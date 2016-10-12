class RegistrationDatesUseDatetime < ActiveRecord::Migration[5.0]
  def change
    change_column :registrations, :registered_at, :datetime
    change_column :registrations, :registered_until, :datetime
  end
end

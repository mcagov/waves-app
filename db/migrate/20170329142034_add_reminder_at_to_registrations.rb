class AddReminderAtToRegistrations < ActiveRecord::Migration[5.0]
  def change
    add_column :registrations, :renewal_reminder_at, :datetime
    add_column :registrations, :expiration_reminder_at, :datetime
    add_column :registrations, :termination_at, :datetime
  end
end

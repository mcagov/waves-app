class EnableVesselStateMachine < ActiveRecord::Migration[5.1]
  def change
    remove_column :registrations, :section_notice_at, :datetime
    remove_column :registrations, :termination_notice_at, :datetime

    add_column :vessels, :state, :string, index: true
  end
end

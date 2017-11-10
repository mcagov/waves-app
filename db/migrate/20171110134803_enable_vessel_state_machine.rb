class EnableVesselStateMachine < ActiveRecord::Migration[5.1]
  def change
    remove_column :registrations, :section_notice_at, :datetime
    remove_column :registrations, :termination_notice_at, :datetime

    add_column :vessels, :state, :string, index: true
    add_column :vessels, :section_notice_issued_at, :datetime
    add_column :vessels, :termination_notice_issued_at, :datetime
    add_column :vessels, :terminated_at, :datetime
  end
end

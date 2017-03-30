class AddTerminationNoticeAtToRegistrations < ActiveRecord::Migration[5.0]
  def change
    add_column :registrations, :termination_notice_at, :datetime
  end
end

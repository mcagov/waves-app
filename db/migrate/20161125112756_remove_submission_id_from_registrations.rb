class RemoveSubmissionIdFromRegistrations < ActiveRecord::Migration[5.0]
  def change
    remove_column :registrations, :submission_id, :uuid
  end
end

class RemoveSubmissionIdFromClientSessions < ActiveRecord::Migration[5.0]
  def change
    remove_column :client_sessions, :submission_id, :uuid
  end
end

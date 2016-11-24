class AddSubmissionInfoToRegistrations < ActiveRecord::Migration[5.0]
  def change
    add_column :registrations, :registry_info, :json
    add_column :registrations, :submission_ref_no, :string, index: true
  end
end

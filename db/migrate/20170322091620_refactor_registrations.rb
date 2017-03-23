class RefactorRegistrations < ActiveRecord::Migration[5.0]
  def change
    remove_column :registrations, :submission_ref_no, :string, index: true
    remove_column :registrations, :task, :string

    add_column :submissions, :registration_id, :uuid
  end
end

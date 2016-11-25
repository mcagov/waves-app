class IndexRegistrations < ActiveRecord::Migration[5.0]
  def change
    add_index :registrations, :submission_ref_no
    add_index :registrations, :vessel_id
  end
end

class RemoveOfficialNoFromRegistrations < ActiveRecord::Migration[5.0]
  def change
    remove_column :registrations, :official_no, :integer
  end
end

class AddOfficialNoToRegistrations < ActiveRecord::Migration[5.0]
  def change
    add_column :registrations, :official_no, :integer
  end
end

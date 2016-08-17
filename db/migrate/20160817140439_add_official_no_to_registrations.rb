class AddOfficialNoToRegistrations < ActiveRecord::Migration[5.0]
  def change
    add_column :registrations, :official_no, :integer
    execute "CREATE SEQUENCE registrations_official_no_seq START 100001"
  end
end

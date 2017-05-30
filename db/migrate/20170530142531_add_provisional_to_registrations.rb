class AddProvisionalToRegistrations < ActiveRecord::Migration[5.0]
  def change
    add_column :registrations, :provisional, :boolean, default: false, allow_nil: false
  end
end

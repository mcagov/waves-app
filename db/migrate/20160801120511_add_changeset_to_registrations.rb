class AddChangesetToRegistrations < ActiveRecord::Migration[5.0]
  def change
    add_column :registrations, :changeset, :json
  end
end

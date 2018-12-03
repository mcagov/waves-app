class AddApplicationTypeToRegistrations < ActiveRecord::Migration[5.2]
  def change
    add_column :registrations, :application_type, :string
  end
end

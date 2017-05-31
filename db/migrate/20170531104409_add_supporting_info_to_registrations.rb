class AddSupportingInfoToRegistrations < ActiveRecord::Migration[5.0]
  def change
    add_column :registrations, :supporting_info, :string
  end
end

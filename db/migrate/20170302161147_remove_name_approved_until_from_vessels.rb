class RemoveNameApprovedUntilFromVessels < ActiveRecord::Migration[5.0]
  def change
    remove_column :vessels, :name_approved_until, :datetime
  end
end

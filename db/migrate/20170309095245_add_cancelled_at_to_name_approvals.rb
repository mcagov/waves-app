class AddCancelledAtToNameApprovals < ActiveRecord::Migration[5.0]
  def change
    add_column :name_approvals, :cancelled_at, :datetime
  end
end

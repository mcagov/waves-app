class RemoveStateFromNameApprovals < ActiveRecord::Migration[5.0]
  def change
    remove_column :name_approvals, :state, :string
  end
end

class AddStateToNameApprovals < ActiveRecord::Migration[5.0]
  def change
    add_column :name_approvals, :state, :string, index: true
  end
end

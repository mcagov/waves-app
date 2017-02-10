class AddManagingOwnerIdToSubmissions < ActiveRecord::Migration[5.0]
  def change
    add_column :submissions, :managing_owner_id, :uuid
  end
end

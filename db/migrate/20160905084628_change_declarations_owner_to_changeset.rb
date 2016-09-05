class ChangeDeclarationsOwnerToChangeset < ActiveRecord::Migration[5.0]
  def change
    rename_column :declarations, :owner, :changeset
  end
end

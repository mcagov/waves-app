class RenameOwnersForenameToFirstName < ActiveRecord::Migration
  def change
    rename_column :owners, :forename, :first_name
  end
end

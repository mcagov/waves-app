class RenameOwnersSurnameToLastName < ActiveRecord::Migration
  def change
    rename_column :owners, :surname, :last_name
  end
end

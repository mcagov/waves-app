class Rename < ActiveRecord::Migration[5.2]
  def change
    rename_column :declaration_group_members, :declaration_id, :declaration_owner_id
  end
end

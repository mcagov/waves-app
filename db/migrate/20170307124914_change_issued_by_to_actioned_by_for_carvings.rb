class ChangeIssuedByToActionedByForCarvings < ActiveRecord::Migration[5.0]
  def change
    rename_column :carving_and_markings, :actioned_by_id, :actioned_by_id
  end
end

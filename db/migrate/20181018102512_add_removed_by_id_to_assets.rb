class AddRemovedByIdToAssets < ActiveRecord::Migration[5.2]
  def change
    add_column :assets, :removed_by_id, :uuid
  end
end
